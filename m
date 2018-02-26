Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2275mzZsYPgW1olYlT+E9qrqMTLjth7DE2cgQQ4DfJCIc8ChsAR43vrOpEq1sQyNe6bbJbpb
ARC-Seal: i=1; a=rsa-sha256; t=1519676544; cv=none;
        d=google.com; s=arc-20160816;
        b=Yu2EUM/HSVFf+FytAlSTnh4Y0qXjccogEy0S6/241NtDDcKguZtbwu1D6FsMyi/u9a
         mBoDIopMWYPLPKeqg9C95Ze9DoGfOXTgCwe+mR315ScjNjOEUyU7BOGb8HuhRrmHzDfs
         +zGATLVckzWs7a/ayqu3ooSccN10vhClx/iExai+Bui5Pti7NAlJZRZ7AUfT5b4kwX/4
         bLfsEy+en8LoUVaWhFj0vejKD21JMb2Wo4wdyVJH0m0VyfroKI9q1Fc4o99jvHcYwwMs
         iPPgtw6uJnjMZ/uSthPCq3WdOTPiJsAK4IJEqKvEKOWoun6H31l9OKyf7T7VFfIzxs0b
         HoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PPcCaKhpyhi2+nE/5Bhq8iCkcZvj0JM30xX6vYRsYZc=;
        b=ab7HSPNBktpLralqnpWhxG1B4nfwjenVz1/q9XT4AfbrLIlvQhgOzZnAnOtzGL2/Dm
         ajLPlCEUBWLoyWmAwNO+pcYg+UOTmbRi4XvvtyCQ/4UJQyXrHn2eyNR+CzLLxLu0462i
         E/MlLEcwpneUWG8AFvmZNbnYsQHTbkO03y//xaRJI6QaAyn4qt++5D3jagLyD+bR+t/o
         UPDswcABZj3/IpOPjoaD2fA5fve8IYogIjjx0JX6Er17hEuU3UIEH1pnQYtFf1eYWibt
         Kwymk+Jz2f4tn9U1rG0BhdGe1/4G8I/BVwqui5yrQu+TNDExsdzsMvRn/AJHOLcWPWyR
         bIWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.9 31/39] libnvdimm: fix integer overflow static analysis warning
Date: Mon, 26 Feb 2018 21:20:52 +0100
Message-Id: <20180226201645.039001170@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496352333936285?=
X-GMAIL-MSGID: =?utf-8?q?1593496352333936285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 58738c495e15badd2015e19ff41f1f1ed55200bc upstream.

Dan reports:
    The patch 62232e45f4a2: "libnvdimm: control (ioctl) messages for
    nvdimm_bus and nvdimm devices" from Jun 8, 2015, leads to the
    following static checker warning:

            drivers/nvdimm/bus.c:1018 __nd_ioctl()
            warn: integer overflows 'buf_len'

    From a casual review, this seems like it might be a real bug.  On
    the first iteration we load some data into in_env[].  On the second
    iteration we read a use controlled "in_size" from nd_cmd_in_size().
    It can go up to UINT_MAX - 1.  A high number means we will fill the
    whole in_env[] buffer.  But we potentially keep looping and adding
    more to in_len so now it can be any value.

    It simple enough to change, but it feels weird that we keep looping
    even though in_env is totally full.  Shouldn't we just return an
    error if we don't have space for desc->in_num.

We keep looping because the size of the total input is allowed to be
bigger than the 'envelope' which is a subset of the payload that tells
us how much data to expect. For safety explicitly check that buf_len
does not overflow which is what the checker flagged.

Cc: <stable@vger.kernel.org>
Fixes: 62232e45f4a2: "libnvdimm: control (ioctl) messages for nvdimm_bus..."
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvdimm/bus.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -812,16 +812,17 @@ static int __nd_ioctl(struct nvdimm_bus
 		int read_only, unsigned int ioctl_cmd, unsigned long arg)
 {
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
-	size_t buf_len = 0, in_len = 0, out_len = 0;
 	static char out_env[ND_CMD_MAX_ENVELOPE];
 	static char in_env[ND_CMD_MAX_ENVELOPE];
 	const struct nd_cmd_desc *desc = NULL;
 	unsigned int cmd = _IOC_NR(ioctl_cmd);
 	void __user *p = (void __user *) arg;
 	struct device *dev = &nvdimm_bus->dev;
-	struct nd_cmd_pkg pkg;
 	const char *cmd_name, *dimm_name;
+	u32 in_len = 0, out_len = 0;
 	unsigned long cmd_mask;
+	struct nd_cmd_pkg pkg;
+	u64 buf_len = 0;
 	void *buf;
 	int rc, i;
 
@@ -882,7 +883,7 @@ static int __nd_ioctl(struct nvdimm_bus
 	}
 
 	if (cmd == ND_CMD_CALL) {
-		dev_dbg(dev, "%s:%s, idx: %llu, in: %zu, out: %zu, len %zu\n",
+		dev_dbg(dev, "%s:%s, idx: %llu, in: %u, out: %u, len %llu\n",
 				__func__, dimm_name, pkg.nd_command,
 				in_len, out_len, buf_len);
 
@@ -912,9 +913,9 @@ static int __nd_ioctl(struct nvdimm_bus
 		out_len += out_size;
 	}
 
-	buf_len = out_len + in_len;
+	buf_len = (u64) out_len + (u64) in_len;
 	if (buf_len > ND_IOCTL_MAX_BUFLEN) {
-		dev_dbg(dev, "%s:%s cmd: %s buf_len: %zu > %d\n", __func__,
+		dev_dbg(dev, "%s:%s cmd: %s buf_len: %llu > %d\n", __func__,
 				dimm_name, cmd_name, buf_len,
 				ND_IOCTL_MAX_BUFLEN);
 		return -EINVAL;

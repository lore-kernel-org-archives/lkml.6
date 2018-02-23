Return-Path: <dan.j.williams@intel.com>
X-Google-Smtp-Source: AH8x225FN6WS1lpdLB4JpXo5WtSfNpVxEhDEPmlExqmGTe1l/htB+YMBjeSkj1OvwT4MT4W0ZAjX
ARC-Seal: i=1; a=rsa-sha256; t=1519424084; cv=none;
        d=google.com; s=arc-20160816;
        b=r5tLN4K6+2IQcpgN8UKCk67tLAxcptD4bTcRBkFRzhWGMcgQGHUi4+7VRe/M1k+VH6
         P2ccNi343Z3lc5/QSwV75bfM46WMAMQabiIKcLHzrZwWeRGZV46scG0eZLKf02fgyJK/
         StkRCEO1lYxd31h/VoeilzFYcgVKRNixh0f3j57+aoV6Q76P1uaAonIXeMxGw17XXtpn
         XW0tUSkGskb/DGj3VdCM0r9x4b46d8YZ4WcabdU+rE2mNZ9m/wYfr28vm8BedKEIpxmA
         LEmG8Slgbpz/5OBXFT7E2auqnQYk5xMNoe/pdakf8Mge/JPlrji0HBkGr1guUYG72jIw
         W/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject
         :arc-authentication-results;
        bh=ZJ2iWapV1bD0OH9pfPsbCfRXowHFo7hDz2e0Pp1IfwA=;
        b=aZ9Dcoms1o69yBz1Sey4x3yWSsK9hp8TxLXZAS1VPwS/YZhmu/V/0cYQmWLM/sYedK
         ubhyn7VBlngA/TzAaKwei1QK9Ty6fcv8mvGoJHSg7MB7a7OKjdCQ1hqk/x2VffP96gFD
         AzEpJDNQWDHuK0YcMru7mjLa8AsuuxMcW4oj5mDiqBiuxXWpX9TKq72fhnClnAP9RUbt
         e+GwAcglI3YvTKy8FvRAlk8BFTBsL385ITi0aEeGABApFlg/W+N6ecvZgeUtqMR2YAnB
         kaldrl5EGXPgPG8CzM6p67R0QtTIsh6GJADOvb9EI2cHN7bxjCqFbXIs5aHVJPNcm3K2
         xONw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="19805346"
Subject: [4.9-stable PATCH 03/11] libnvdimm: fix integer overflow static
 analysis warning
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 linux-kernel@vger.kernel.org
Bcc: dan.j.williams@intel.com
Date: Fri, 23 Feb 2018 14:05:38 -0800
Message-ID: <151942353841.21775.10479863744600514056.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231628982860596?=
X-GMAIL-MSGID: =?utf-8?q?1593231628982860596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 drivers/nvdimm/bus.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 0392eb8a0dea..8311a93cabd8 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -812,16 +812,17 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
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
 
@@ -882,7 +883,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 	}
 
 	if (cmd == ND_CMD_CALL) {
-		dev_dbg(dev, "%s:%s, idx: %llu, in: %zu, out: %zu, len %zu\n",
+		dev_dbg(dev, "%s:%s, idx: %llu, in: %u, out: %u, len %llu\n",
 				__func__, dimm_name, pkg.nd_command,
 				in_len, out_len, buf_len);
 
@@ -912,9 +913,9 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
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

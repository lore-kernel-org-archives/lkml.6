Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELttH8TdM5/BcoDJJuHnug9S46s+JsR/n9Xbu6HQKRxHJ29h/4dA43PPDYcYCnDOS4NGV2jY
ARC-Seal: i=1; a=rsa-sha256; t=1520451614; cv=none;
        d=google.com; s=arc-20160816;
        b=exwgR1G5uf4NjwCKZKH8ssL+L8oGrGUVj/Wewf8uej+PpWoqJ5Fo29ag2ov9ruPFRX
         /DgP/Up9lLOb/B4Fdpdtx1yv47qma560shv454IJ6kHcgVHmOm0nPx/CiEWbj6AwHlca
         i8uf74vGakLM+Z/hx+WxtCxKG5UucJTTnoveYA3LVqaqpCqmSz/jBJat3ndQr4CgGrNt
         i5y7xhXVMkpTQbYgPRB44OCX5K1m7hWDNCCejJIa8HEhD7WcLWTYuSEjhUy31WdXru5c
         KOBqvaWdiGEFxxi0MaSOZXeNIJYAvSdrswPw20UyGm/O09amWi6dFisz/XzlI/Nc8k8A
         mmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NvZJdFsI1F+EUmOHqQFeeB9WRUniWIzbiju3NVFY+Nc=;
        b=HgjU40CJ2q9yb9OpQMrsXknHykmRhGQDfKjMQHS2AOkzY1NN78xrG4+ucbDdl8KfS7
         bgKb5imlpSQONlFgtM9r1xUZZlkqAGeWRunIGo0M/fY8SfYiMlKZHGq3NSBKE9OQS4gK
         7KvHYXRVn5EaX/mQCbrj2QXPTjkuzdP2TMUTnpHehFulE+VJ75+wSval2kwsXKpa/Ybu
         eQwoWUcOXVp2PChh3ieOaiOsVerTiavhoL3SJAYJYr9e1NyHPRHKeMOQD7ck9yrd9ae/
         IlbVSWT7qwnRZjPq3SH3XaPWxBpDjzagtOU7kbmrj8e/FmM0XUhjwkJiZF9kENDdAOIv
         xeGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 020/122] mmc: dw_mmc: Avoid accessing registers in runtime suspended state
Date: Wed,  7 Mar 2018 11:37:12 -0800
Message-Id: <20180307191732.271719877@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309071701629543?=
X-GMAIL-MSGID: =?utf-8?q?1594309071701629543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

commit 5b43df8b4c1a7f0c3fbf793c9566068e6b1e570c upstream.

cat /sys/kernel/debug/mmc0/regs will hang up the system since
it's in runtime suspended state, so the genpd and biu_clk is
off. This patch fixes this problem by calling pm_runtime_get_sync
to wake it up before reading the registers.

Fixes: e9ed8835e990 ("mmc: dw_mmc: add runtime PM callback")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -165,6 +165,8 @@ static int dw_mci_regs_show(struct seq_f
 {
 	struct dw_mci *host = s->private;
 
+	pm_runtime_get_sync(host->dev);
+
 	seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));
 	seq_printf(s, "RINTSTS:\t0x%08x\n", mci_readl(host, RINTSTS));
 	seq_printf(s, "CMD:\t0x%08x\n", mci_readl(host, CMD));
@@ -172,6 +174,8 @@ static int dw_mci_regs_show(struct seq_f
 	seq_printf(s, "INTMASK:\t0x%08x\n", mci_readl(host, INTMASK));
 	seq_printf(s, "CLKENA:\t0x%08x\n", mci_readl(host, CLKENA));
 
+	pm_runtime_put_autosuspend(host->dev);
+
 	return 0;
 }
 

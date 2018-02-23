Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsOVxYdIgnMQ+Tt0cHDKcijWz5HTNY+1o4Edhehx7dy2Xxi8RwovGaarva5LniN7cvovLJO
ARC-Seal: i=1; a=rsa-sha256; t=1519411072; cv=none;
        d=google.com; s=arc-20160816;
        b=s0q3DyjP9PF0B9M2CWlTkr8/Vyx7Ft1dvp7bnYSs7YyrwMLJQ4hmW3HAhwUDs+dwsH
         e3XdhJjGsn1rcUkfBt8NOHYQ/BOLk6ANcFvxiAl5EEfwFbMJiu8WcXxWK1q4xcMrT7d9
         FObrPgfDhwJ/frVRM1nLHLHw8pE3XTnKMHpHFkurucLwjOdp1QVpXDK3Wi+4LCq6+l57
         /JtJ7cVNNdU3HG9mTOa74k3LoxN8O2ESweFv/tPBDF3T/AG5QGPj851QRnquoYKeSU5V
         pyNva5BqOcXz0RlaaUAfhkkxB/BIiuRSwTvPKh79P7jTHSWjAfY6i5zdRtLskpFnoUla
         WGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BKpr4H7msAsK9ME2GbrN7w2i16zkM/cf+DTGEXVBPV0=;
        b=sbHBUADrZlObA2NE+80M/O6E+tf8Hk/N+GwybHYQpxWmfZVhlsvsSHZX6dVVVnTzqI
         z93+UN4Do0MiXw8MWyI3BxyZoYZkVutTXl1rMvFaZHXoLaUsEdHHTM5fGiQDwRIIpXTk
         qetUr3jMM5shXzz3oRKqUV08/Nd7CTBUmmm15qj1z6ZuPQlO87+b3nM8kddGKDsTKlLz
         uBKsaK0sTmvF4hw1K7JfnbOzVhZoQbPQf4ikKF66ay0HBHd1L9yQXdxbemJBdUPzEUtg
         a5+b3iyaOcYYtrwVGFTD9a/1At0Baa56iwP6z1zxz4yPjeEkZb6vxbTkJvDB21ypkhEO
         mX4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sudip Mukherjee <sudip@vectorindia.org>
Subject: [PATCH 4.4 110/193] Drivers: hv: vmbus: fix build warning
Date: Fri, 23 Feb 2018 19:25:43 +0100
Message-Id: <20180223170343.137986981@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217984543133796?=
X-GMAIL-MSGID: =?utf-8?q?1593217984543133796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit 9220e39b5c900c67ddcb517d52fe52d90fb5e3c8 upstream.

We were getting build warning about unused variable "tsc_msr" and
"va_tsc" while building for i386 allmodconfig.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/hv.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -195,9 +195,7 @@ int hv_init(void)
 {
 	int max_leaf;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
-	union hv_x64_msr_hypercall_contents tsc_msr;
 	void *virtaddr = NULL;
-	void *va_tsc = NULL;
 
 	memset(hv_context.synic_event_page, 0, sizeof(void *) * NR_CPUS);
 	memset(hv_context.synic_message_page, 0,
@@ -243,6 +241,9 @@ int hv_init(void)
 
 #ifdef CONFIG_X86_64
 	if (ms_hyperv.features & HV_X64_MSR_REFERENCE_TSC_AVAILABLE) {
+		union hv_x64_msr_hypercall_contents tsc_msr;
+		void *va_tsc;
+
 		va_tsc = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
 		if (!va_tsc)
 			goto cleanup;

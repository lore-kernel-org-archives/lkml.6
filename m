Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrg2aThd1AE+ZnMHANo3YjCGin+nIebR9rGy2gTcU9K+nCQ8JyMcNntC1TpOl0xlKIHhC8l
ARC-Seal: i=1; a=rsa-sha256; t=1525116491; cv=none;
        d=google.com; s=arc-20160816;
        b=sp6bxrTvX+boUZnIbIEEc2annXXGaZ2Pl7eCEMN1uktdsWWwP7OIfyQnmOxs25yD8E
         yHLbWRPf7C/idznwMGThIcItctWawkWOvVye3V58eJMGQSfOLrnayu1Kk9Zz9FWX35CS
         OrOXtSgUsEfTNOQOSQPdaQWaGnWMukWMDpRcu3KxiSKpsLUuQEYrean/R8MfcHHcof+M
         HG1faImhVQUjdqQ7UYJ0SGXRMNvaL9l/cgK2lMPBkV7kFNm/mcQL8Fw+3CEpSxa9RXoz
         XKo+24vwOgaauaZp4RvMaBoVpnH7kdaqM4T4pZOOKTPDcEQNsEzhS1KdVfqVpaqYU1wv
         Jtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=eOOeAfLn++5JdNJeV7M5bJQziBRaZDFHlr1P+1K+DxE=;
        b=0EVVqiN/5ThFlYqPGh8dphreDATPty6LC40EoWzbADP6syNxmXw2zrQheLTcbImzbS
         alMwbL4BO0YdWAZ41q1j0+/ylqHw4g6c0MaZGI/TdJ/7GQbMwpIo99Kdf61NlWiQrCXP
         hiUfRjhKy/tk9fFRRHhie+4w6an1SD1Y4hSCux4bjqT0JaWRqiE42F2BWgzhALTkRmCk
         cVeq2wzDITCtVRhfJnE1Z7Y03TLRQ10Bkv89DByQggt0/Cl+d6UvdC5KsiYFggmgtPqS
         y4HFTHcO64PfSF3M1TczHKFYm4F0DIWWnIUqOJkHy7h6/KtGaOVp0DPqrrFZovjgtqL9
         HkQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1839922DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 007/113] random: fix possible sleeping allocation from irq context
Date: Mon, 30 Apr 2018 12:23:38 -0700
Message-Id: <20180430184015.381778399@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200450435122666?=
X-GMAIL-MSGID: =?utf-8?q?1599200550380222631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 6c1e851c4edc13a43adb3ea4044e3fc8f43ccf7d upstream.

We can do a sleeping allocation from an irq context when CONFIG_NUMA
is enabled.  Fix this by initializing the NUMA crng instances in a
workqueue.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com
Fixes: 8ef35c866f8862df ("random: set up the NUMA crng instances...")
Cc: stable@vger.kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -788,7 +788,7 @@ static void crng_initialize(struct crng_
 }
 
 #ifdef CONFIG_NUMA
-static void numa_crng_init(void)
+static void do_numa_crng_init(struct work_struct *work)
 {
 	int i;
 	struct crng_state *crng;
@@ -809,6 +809,13 @@ static void numa_crng_init(void)
 		kfree(pool);
 	}
 }
+
+static DECLARE_WORK(numa_crng_init_work, do_numa_crng_init);
+
+static void numa_crng_init(void)
+{
+	schedule_work(&numa_crng_init_work);
+}
 #else
 static void numa_crng_init(void) {}
 #endif

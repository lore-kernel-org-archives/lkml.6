Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx49xTsMcW828NS8rJJlHr1/r3h7hx/4kpWyv85CO5Mc7whpVvytyoQnOo+aM0ftKbiuxzIPm
ARC-Seal: i=1; a=rsa-sha256; t=1524652438; cv=none;
        d=google.com; s=arc-20160816;
        b=lWwtRRfNwTH9aSvbUiJ4CxlWC6mFAZcLfsjCq1jCdLeQqpkERK2JMwHHI2tumtq4zg
         44csqCiYc13r8U3xkZXxtfXW81T+r8FEGO+rGvDa2WxL5ca1UnZEaLtQ2tOSVZBpw3O9
         crgnukdrsL9z6QFT19RNu5t3Ey3Y4LsOPaIJgCQuveFsGuXFYxh8+7h7xWfEV7gUg1pF
         K2q/SGbJs/x1zEwV2cCxNyrgNljhloxtPRu4D5Auq3wOgRAHL4qt9hSvrMsEs2FXwrhO
         jvhCebVeTQKd3uhkH/KaHKmT6CFPECKdyqt6IZ/qiaquHkFQdgIFuCR1lekDig5laJiY
         S5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=D6SuJTv+bm1bZOFsjflgliHQDzu177y70KNdYN5nuDI=;
        b=G89cYHd+qvFeh48vqp1oDGmljJY50Hn0caCTuRUCNVs3myeYuw+SY4QYnw37F0wKmA
         Yi9WX7/4PvcUzUBazry8Y/RKg8mUtwWQpb6KqQFcnFUKf84TQqd8FJTx6bh2pKg1FVZU
         5TVpg2VQnqpbX/PyoD6FoR2bDG9wRtN+8LHx24yZ1R/qyNSWZ8eGS/LlkMKFXSlsknE5
         9/DM6axcE9xIqY8IDxKVBUAa4J1MzQ9F2uMT3DoNW2ZxOZh1TZB+OXlNra96xqYy5Dcd
         sajO87MfLEr9dZisUHa5ayWLQblEfhZ0G6/gMinug6F41C/zWYhoi0vKhgYdCssLxKXQ
         F8Lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <hpa@zytor.com>, <gregkh@linuxfoundation.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v3 1/2] x86/mce: new Centaur CPU support MCE broadcasting
Date: Wed, 25 Apr 2018 18:33:39 +0800
Message-ID: <1524652420-17330-2-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524652420-17330-1-git-send-email-davidwang@zhaoxin.com>
References: <1524652420-17330-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598713954943816107?=
X-GMAIL-MSGID: =?utf-8?q?1598713954943816107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Newer Centaur multi-core CPU also support MCE broadcasting to all cores. But
no Centaur special code tell this truth to kernel.  

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf288..38ccab8 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1727,6 +1727,22 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 	}
 }
 
+void mce_centaur_feature_init(struct cpuinfo_x86 *c)
+{
+	struct mca_config *cfg = &mca_cfg;
+
+	 /*
+	  * All newer Centaur CPUs support MCE broadcasting. Enable
+	  * synchronization with a one second timeout.
+	  */
+	if (cfg->monarch_timeout < 0) {
+		if ((c->x86 == 6 && c->x86_model == 0xf &&
+			c->x86_stepping >= 0xe) || c->x86 > 6)
+			cfg->monarch_timeout = USEC_PER_SEC;
+	}
+}
+
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -1739,6 +1755,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_amd_feature_init(c);
 		break;
 		}
+	case X86_VENDOR_CENTAUR:
+		mce_centaur_feature_init(c);
+		break;
 
 	default:
 		break;
-- 
1.9.1

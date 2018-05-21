Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpvEoIgi0BPfQSU6YuJPiPuTacumChAg01il7WEvorVr1sSMS8YEPjS7HY6x1oiBdpwLcq0
ARC-Seal: i=1; a=rsa-sha256; t=1526937401; cv=none;
        d=google.com; s=arc-20160816;
        b=Jzv406jfJZe2F/HpwAIom7CnnzQzskpEFF7zOMZt/993ItA8wJNjbco7qc7M3Wb8Y8
         ZcneFjt4lpllc76uLt79wfZyzZheLbwuB8ja6bfZzVxEvwwFOO/QWICuOFdbGt7GdaEs
         SwWyyzX885K7lW6xikcxNnzqOOdVfLwte2+9b2vnstdMbMOnubVY/PeghzAJkdT6kSeb
         yh7tfX5ur+tXQJ6F7haQXEKpy0A3mOTmHSGlwkgG8Jmyre5nE/TWiDx28qnLt+VUTbot
         XJfPN4AIX0dXpKiX50BieKXuuwvdUB74c++L4gisE1uOYvu1fDv9GmU3w+pFPmDZQegN
         NaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=29AKCw3UvMRji1RgifUjvINN/GPRl65hFy6MIN0fBco=;
        b=H4xRzZIvh/zvxwSwmQuGlN+s2WA0uGaICL9/7XX8Mb3olwZHgTZcVXaKHIFE1vDXIE
         2uHUN9qT7aqOD/mJ1iscDufp1Um7/5BFNBRt9d1Rui8Ns5p4P5cDGnwAUlRO82ES1eW5
         5SKBedbSc+DKIXo4MotiikXp5yIm2NoJxIBLeNTa8z4Cmd6AA3rNuKbe7DxUDsIyyIJw
         z9HczYHYTvWiVV/mdypuyV4YWTm6sjlaiz2VPBDs3fW7V0aTKkFQ4hBclCQBWsJQpI4Y
         0btv0qkoiGHuWEm8kp87kr5O6o16c7U3PePpU+Fpsr8L8RfdK4U7hPYgljIc5ob03dV3
         LicQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gQwM/r/s;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gQwM/r/s;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 69/87] x86/bugs: Fix the parameters alignment and missing void
Date: Mon, 21 May 2018 23:11:45 +0200
Message-Id: <20180521210426.119520188@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109912945612941?=
X-GMAIL-MSGID: =?utf-8?q?1601109912945612941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit ffed645e3be0e32f8e9ab068d257aee8d0fe8eec upstream

Fixes: 7bb4d366c ("x86/bugs: Make cpu_show_common() static")
Fixes: 24f7fc83b ("x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -530,7 +530,7 @@ static enum ssb_mitigation __init __ssb_
 	return mode;
 }
 
-static void ssb_select_mitigation()
+static void ssb_select_mitigation(void)
 {
 	ssb_mode = __ssb_select_mitigation();
 
@@ -640,7 +640,7 @@ void x86_spec_ctrl_setup_ap(void)
 #ifdef CONFIG_SYSFS
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
-			char *buf, unsigned int bug)
+			       char *buf, unsigned int bug)
 {
 	if (!boot_cpu_has_bug(bug))
 		return sprintf(buf, "Not affected\n");

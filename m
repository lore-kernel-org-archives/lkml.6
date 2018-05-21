Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZraA1ynfQx8WsUuaw9z2lMa3N3jLP9csysU3AJOJqNWC07CsXagkYZawrErlv8KPtFE/IKu
ARC-Seal: i=1; a=rsa-sha256; t=1526937668; cv=none;
        d=google.com; s=arc-20160816;
        b=rJTf2/8JivGRDJKWpfzY1Oc0RqGz2UWePFmd8nJ1Jo2LkIVHxzeDKFiy1FYeY3QSdG
         acyL77nlZjDZoICBoXgcfzQF7awYuJldc4r6oxk7jkE9NKhD9a6za173G9cpz3lXP7DD
         gtYoUD3cJfxKeUZWzIxYmNIt4jGQsAEySTpsRZiQANThEYbC9WAglJIcJfHktCduVdPM
         5Cf+lV9pDfcS5jV86hTMvQ0gZ/AocrbTWEIlgZ/607L42EqBDkPSRR1mr2bhH86sl1iy
         L5pLeZfUwvnGs0tAwLtNV53VE6aYMZ1pxflyyJIHR9fSWSpMf2DpOJe9vR0B0g85T268
         eNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=g+TsEMZGn/Zc5Ug9/03vSqqjnBAauUk6EN7lIMIxh5E=;
        b=luFHIm97lKeULQPRwvhTPdC7IYMj+jANq1AO8hAgFw26k3x3i+DsR65wIncPpoQ68E
         Z0VpcqcHFoiJ/UCTbMEZ/orZSMUvBr6uzGiVN4Jv87hqcKMLz3Wlgwz/ytUFTkjA1vcm
         10qabjN6JL3NkZT8cd1yCvzQpKQP/OhXv0OtHsAHjnViffysmA2MQ7JzgOblJzaakjVp
         iLXmNXXZ2HqgtnC7l8bnjcHu7dGOeNlaM+EKa2qrMmgiyQtk08CwGGKYvZLxNUT7Z9Yj
         6mhSJB+RoskYr8u93pm5T821A/EUU2TCbCTt1XE2tq6TQ5z3+IT8IUqoRJ6PginlEgZl
         OT7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Te+m7sC5;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Te+m7sC5;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 78/95] x86/bugs: Fix the parameters alignment and missing void
Date: Mon, 21 May 2018 23:12:08 +0200
Message-Id: <20180521210501.955018111@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109912945612941?=
X-GMAIL-MSGID: =?utf-8?q?1601110191730435221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit ffed645e3be0e32f8e9ab068d257aee8d0fe8eec upstream

Fixes: 7bb4d366c ("x86/bugs: Make cpu_show_common() static")
Fixes: 24f7fc83b ("x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -531,7 +531,7 @@ static enum ssb_mitigation __init __ssb_
 	return mode;
 }
 
-static void ssb_select_mitigation()
+static void ssb_select_mitigation(void)
 {
 	ssb_mode = __ssb_select_mitigation();
 
@@ -641,7 +641,7 @@ void x86_spec_ctrl_setup_ap(void)
 #ifdef CONFIG_SYSFS
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
-			char *buf, unsigned int bug)
+			       char *buf, unsigned int bug)
 {
 	if (!boot_cpu_has_bug(bug))
 		return sprintf(buf, "Not affected\n");

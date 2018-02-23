Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224myFtSWiMwffM/5zhkJFGz8goljGlg1/2bq86mmYPhLGbWZ7Bbamm7SYhNCzQMORG1Nt8T
ARC-Seal: i=1; a=rsa-sha256; t=1519411194; cv=none;
        d=google.com; s=arc-20160816;
        b=HjRyW5/kZtB/ufhVhjN1vidNBeOo15vU+Bp0w5koNKZk1KGXdvoaTtfNO9u2WCarhv
         p2GTDWw3Z+1mwsxXpEjl62FxoRoFqEb0MQprBjR4yduHKFPeggUNvQN3qmlmizajDNgt
         GjwIYwCAz/GHWx1sPVoknSUSDPbmmHdOSAcCd3+g0FkDf65MWsmvvNuAUXTBlyYfl2Kv
         W2KNPpRh9C8TNHH0/j9KWxxQ93ddQyC5CC3uGCW6FkDOYsjqk4l1Wo5NG0nChdJFEocE
         uLTr8VwPOvV+01JkzmfR2sfJpQRCuHBikP2gflnCq2fy/ldGpOYtYrLquNkH40JaEwtv
         Ez8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iBKXR6AeJ0Oob0bJy1+DhT5rGFa+a7dcRDucSotqlIw=;
        b=YOO9ycgt6iTQlqiqt4aNygiTsbM6a7+zEKAmHJaWbQ5pxMK1FUYflNp9jBszsdKlpP
         qIcCebD4L3QQfgjbpy8DunvMDsxtKWHz7lik+hTC7RfBZwwLvr+exzonIzp242yL30ni
         XumEDvU3vjEWjeJPsl0/2TWICD4PhaVYK8VwW4xGXJJelubN/JtYzVEd9/Q5dcdJ6FPJ
         YpHaQFpCk7FuuMWn2ioHfqs/VMQU6pDlYvhPWJuVgE6+PFXNqh7vOl+aUqPPVuzveOqB
         fnDWVQp18qnye5OqZqJABZFOmzTjYfYB3WthrUcwLTaG6Afdf2hUBPeysHE5jlPdKJto
         +R0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 152/193] binfmt_elf: compat: avoid unused function warning
Date: Fri, 23 Feb 2018 19:26:25 +0100
Message-Id: <20180223170349.766396281@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218112328279833?=
X-GMAIL-MSGID: =?utf-8?q?1593218112328279833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_ELF_CORE is disabled, we get a harmless warning in the compat
version of binfmt_elf:

fs/compat_binfmt_elf.c:58:13: error: 'cputime_to_compat_timeval' defined but not used [-Werror=unused-function]

This was addressed in mainline Linux as part of a larger rework with commit
cd19c364b313 ("fs/binfmt: Convert obsolete cputime type to nsecs").

For 4.9 and earlier, this just shuts up the warning by adding an #ifdef
around the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/compat_binfmt_elf.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -51,6 +51,7 @@
 #define elf_prstatus	compat_elf_prstatus
 #define elf_prpsinfo	compat_elf_prpsinfo
 
+#ifdef CONFIG_ELF_CORE
 /*
  * Compat version of cputime_to_compat_timeval, perhaps this
  * should be an inline in <linux/compat.h>.
@@ -63,6 +64,7 @@ static void cputime_to_compat_timeval(co
 	value->tv_sec = tv.tv_sec;
 	value->tv_usec = tv.tv_usec;
 }
+#endif
 
 #undef cputime_to_timeval
 #define cputime_to_timeval cputime_to_compat_timeval

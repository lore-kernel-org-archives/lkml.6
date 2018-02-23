Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELslgFcpPivzzq8ZQDEtykqgDJCJzioI7usJsVz8WCp+n+HMk4HQ76PGZZxQ/qs8KSQjEhiJ
ARC-Seal: i=1; a=rsa-sha256; t=1519411068; cv=none;
        d=google.com; s=arc-20160816;
        b=a9FXG22qJs+FaXZLrohUS4bj0JZez3b+/FJql29TWmCm5qvMv0iVXlAwbFlXI+rbQA
         e5b7b4/ImrGUNOZRdK/JDNhdmsO60f5/J6FFDwxI8hi7jwpA6ZVPptS8iDiMQb6ToOKi
         2wv1LbzLDM8s/6oExfYhHv2QEL/UsTFDBs/yXZPH9CbbxPemun5HVO5q7MxjPrahjsYp
         Fa12MSu9L3muzv1+03ew++Bo5UWVgwTKahesimP1fM0jex7ow88brh0gKo20exrFbkUY
         G6se+LPmeE1F45z5SPsllhV4WXKPZ/05IlRS8NbeGkTllJwR1OBGuOyXkPBQ1UhOj33v
         lZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+tMHpoDDE11nDeeqfBnSjKeQ3wKNGdtdd2wg+qNpGJ4=;
        b=TGrtQF/cdI6saJ1zjFNIRyVRK4q3UbcK2IdjtNu3Ly/vZXI5QnNMiqmVqdIh4Po8jv
         kH6BZFx60dKcoA8GwqzsGja7HqFCLyeSHR3I60EScFC7Wz5mg0p9TtWBWJdaCzztTD+f
         uJB5AiIbL3+VUGyrYzhzTGPAB8pA4Sd2fXIXsWJ6JAcvvuafAfik1tgbtTtODJGSg1s4
         aPGBaKm+rjoa+BiRrYsULcVCXfBaW7wc+z/ZAiRHjs1BPG+PkK7md+I+FaKw69Xp3WJk
         lg7B2mLFtemrt2vhDMnevfJegSxEi0hCmSih97XlRwePxMVVQeV9GqcAfc44DM6NCiRG
         M8dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 4.4 109/193] modsign: hide openssl output in silent builds
Date: Fri, 23 Feb 2018 19:25:42 +0100
Message-Id: <20180223170343.002218818@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217980834998490?=
X-GMAIL-MSGID: =?utf-8?q?1593217980834998490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 5d06ee20b662a78417245714fc576cba90e6374f upstream.

When a user calls 'make -s', we can assume they don't want to
see any output except for warnings and errors, but instead
they see this for a warning free build:

 ###
 ### Now generating an X.509 key pair to be used for signing modules.
 ###
 ### If this takes a long time, you might wish to run rngd in the
 ### background to keep the supply of entropy topped up.  It
 ### needs to be run as root, and uses a hardware random
 ### number generator if one is available.
 ###
 Generating a 4096 bit RSA private key
 .................................................................................................................................................................................................................................++
 ..............................................................................................................................++
 writing new private key to 'certs/signing_key.pem'
 -----
 ###
 ### Key pair generated.
 ###

The output can confuse simple build testing scripts that just check
for an empty build log.

This patch silences all the output:
 - "echo" is changed to "@$(kecho)", which is dropped when "-s" gets
   passed
 - the openssl command itself is only printed with V=1, using the
   $(Q) macro
 - The output of openssl gets redirected to /dev/null on "-s" builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 certs/Makefile |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

--- a/certs/Makefile
+++ b/certs/Makefile
@@ -36,29 +36,34 @@ ifndef CONFIG_MODULE_SIG_HASH
 $(error Could not determine digest type to use from kernel config)
 endif
 
+redirect_openssl	= 2>&1
+quiet_redirect_openssl	= 2>&1
+silent_redirect_openssl = 2>/dev/null
+
 # We do it this way rather than having a boolean option for enabling an
 # external private key, because 'make randconfig' might enable such a
 # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
 ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
 $(obj)/signing_key.pem: $(obj)/x509.genkey
-	@echo "###"
-	@echo "### Now generating an X.509 key pair to be used for signing modules."
-	@echo "###"
-	@echo "### If this takes a long time, you might wish to run rngd in the"
-	@echo "### background to keep the supply of entropy topped up.  It"
-	@echo "### needs to be run as root, and uses a hardware random"
-	@echo "### number generator if one is available."
-	@echo "###"
-	openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
+	@$(kecho) "###"
+	@$(kecho) "### Now generating an X.509 key pair to be used for signing modules."
+	@$(kecho) "###"
+	@$(kecho) "### If this takes a long time, you might wish to run rngd in the"
+	@$(kecho) "### background to keep the supply of entropy topped up.  It"
+	@$(kecho) "### needs to be run as root, and uses a hardware random"
+	@$(kecho) "### number generator if one is available."
+	@$(kecho) "###"
+	$(Q)openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
 		-batch -x509 -config $(obj)/x509.genkey \
 		-outform PEM -out $(obj)/signing_key.pem \
-		-keyout $(obj)/signing_key.pem 2>&1
-	@echo "###"
-	@echo "### Key pair generated."
-	@echo "###"
+		-keyout $(obj)/signing_key.pem \
+		$($(quiet)redirect_openssl)
+	@$(kecho) "###"
+	@$(kecho) "### Key pair generated."
+	@$(kecho) "###"
 
 $(obj)/x509.genkey:
-	@echo Generating X.509 key generation config
+	@$(kecho) Generating X.509 key generation config
 	@echo  >$@ "[ req ]"
 	@echo >>$@ "default_bits = 4096"
 	@echo >>$@ "distinguished_name = req_distinguished_name"

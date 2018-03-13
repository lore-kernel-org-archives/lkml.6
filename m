Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuy8hG3HE/FmLiJIlFhLzUWRd1JSehRR74JE29Kro3Ypl9tJlv8gryt7UuhZ4raalLADT9R
ARC-Seal: i=1; a=rsa-sha256; t=1520955295; cv=none;
        d=google.com; s=arc-20160816;
        b=pi3+PeV9Fe6A9FCzvOiZ8hBnyUABpreX5u8UmU1w69QvM8xqgKXiGcG2Y1KA4nJ43j
         OWJ6GxcBxVnCATSyFurVx19snhTkjIztwqlODYjXo5YXmAXC4EDrSswskcCeWnnL4cNi
         eXpbfII+2CPfjk+MuHrJ9g8u6JArL1VXQGOq5fmJrtDCBzDsI0MblNTBVrj+CVvzIoWc
         nTGJuuO98xpYKxkCl/Nk2pPRWFvJ+yRmDvYHX2Cnhr4dAchWc8vLMABfSFla2Mgc3DkW
         aKp9MR3K5Sj8UPLjmczRwPd/fUzQqAtHZPsAJ/1ZkpaDH7E/2eNZca0B85KffiSc8mzx
         c1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6l3xEn/oJCTACo50JzJUGPxEDszrBAynRr2yJDpR+EY=;
        b=TFzWGCyv/GjHKNiiyIUkwVaRBaOOdjjYPVzB0Qm4GgzkJqzmRMe3C347E9rZGWZHgl
         EHthsMert0HGmQ2LXMqIMoPmdN44WT/tZu1b8slZAa4turDqa3cpg1OWwffoih+l94gO
         ukvDBsUlmBf0X/YeNOwRfouhaYQgoazT46fIQzM6WG8bckMTw84jXrkfRgY/MBxMl7/D
         TB1E3U2Oucie453Ycv/MedBlF1JzhgsnF6ScQiQ3JBtUFEcj25Jn0zPocPurfKBYDICc
         ENyVCSVSquMwr0YaMm3GTsvJ0IYVPhYmyvveSpn5l2dmqCuPY0WyR4YVt0pgfURWVTji
         yl6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 4.14 001/140] kbuild: move "_all" target out of $(KBUILD_SRC) conditional
Date: Tue, 13 Mar 2018 16:23:24 +0100
Message-Id: <20180313152458.279778612@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837219769510497?=
X-GMAIL-MSGID: =?utf-8?q?1594837219769510497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit ba634eceb535d95e87ef09caae7814b3687c6036 upstream.

The first "_all" occurrence around line 120 is only visible when
KBUILD_SRC is unset.

If O=... is specified, the working directory is relocated, then the
only second occurrence around line 193 is visible, that is not set
to PHONY.

Move the first one to an always visible place.  This clarifies "_all"
is our default target and it is always set to PHONY.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -11,6 +11,10 @@ NAME = Petit Gorille
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
+# That's our default target when none is given on the command line
+PHONY := _all
+_all:
+
 # o Do not use make's built-in rules and variables
 #   (this increases performance and avoids hard-to-debug behaviour);
 # o Look for make include files relative to root of kernel src
@@ -117,10 +121,6 @@ ifeq ("$(origin O)", "command line")
   KBUILD_OUTPUT := $(O)
 endif
 
-# That's our default target when none is given on the command line
-PHONY := _all
-_all:
-
 # Cancel implicit rules on top Makefile
 $(CURDIR)/Makefile Makefile: ;
 

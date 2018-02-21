Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224I37ZezIxvzcgcLoqFWJjHVl7jsEMxgzKWvXZ3d8kRhboVWAjXkMafdM86loHTCURG2EAn
ARC-Seal: i=1; a=rsa-sha256; t=1519218450; cv=none;
        d=google.com; s=arc-20160816;
        b=Chx2BbfuQIGjrxumaLRpLCqaoQGSpuVRzx2TQgZAmd63RrG3RXcl5Iwa2WBO/jL3YN
         PchXiF66UREx1pxsOMnnt4OTZHpPUayytu+BmfhOMa6js4oPYeR7eM7rWYbEYczAUedS
         6lnL2orPtsKh6GoqvUkjZZxTRKjHEQsFNcoM29sacfPFfRQ1moOJ/XhsvFLoa+pcHvGn
         mQi88tD/QfkjI4OY3og9uOd0Pe2ZpqbnmolXzDkXCp4RQhVm8h8URQKi7tS6VqanVAaR
         CFYPjDw3bOKdimUbiYEnYc/jeTw7Axo0JsMKFlW/vl9zrh7r2xTaSxudGySM2QCoMaOc
         iCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NiBUY/mJjQMSyhbWu7bO+rHFDXeqA3L2vm66cjCpPMo=;
        b=Frlkb8awBGXVpjGnyT7iIcFM96vzMuCO2xyCGJn2HFrodEGn6mb5Xp3Abc+xaExiDH
         IKChhIOfl/I9pcdWS6zN2V4Gi/f8px84NqSbS5BdppwTzrWyYiaBe8l2GMPIuUjOwYLb
         Xml6nwPfVGYwU5ppVn84/8Bt5pvILe0QaMcR/t860iFOUaxWlWmR1pARidGM2ed4Se9T
         efOhWqKo5XgFNtWtYdFrVP8fnKC4jTTIA/EhnjBACjPP5hD8+PX3Is7jEI9gqEw4BF+v
         gb9XzdSJDYuyhdXT/j4+ThxVZxPcjvldMFJBnfFpbes/dMjqZZ8Q+iJQEAM3gHq0EP0s
         +/ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 043/163] compiler-gcc.h: __nostackprotector needs gcc-4.4 and up
Date: Wed, 21 Feb 2018 13:47:52 +0100
Message-Id: <20180221124532.735157701@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015501795366068?=
X-GMAIL-MSGID: =?utf-8?q?1593016005367458703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit d9afaaa4ff7af8b87d4a205e48cb8a6f666d7f01 upstream.

Gcc versions before 4.4 do not recognize the __optimize__ compiler
attribute:

    warning: ‘__optimize__’ attribute directive ignored

Fixes: 7375ae3a0b79ea07 ("compiler-gcc.h: Introduce __nostackprotector function attribute")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler-gcc.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -167,8 +167,6 @@
 
 #if GCC_VERSION >= 40100
 # define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
-
-#define __nostackprotector	__attribute__((__optimize__("no-stack-protector")))
 #endif
 
 #if GCC_VERSION >= 40300
@@ -198,6 +196,7 @@
 
 #if GCC_VERSION >= 40400
 #define __optimize(level)	__attribute__((__optimize__(level)))
+#define __nostackprotector	__optimize("no-stack-protector")
 #endif /* GCC_VERSION >= 40400 */
 
 #if GCC_VERSION >= 40500

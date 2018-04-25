Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZrddVlIGH1eP878VQu52MmPG+vcc6oGAPOb7aHRP0/UBJfnXSbp85WYb8ZrRZAHtZ5r5AaL
ARC-Seal: i=1; a=rsa-sha256; t=1524652766; cv=none;
        d=google.com; s=arc-20160816;
        b=RC1pRR5177kSxKo1YSExpKwjRbiIU+qkRIy7mGz9Cqq0SRSCf5GNKi3diIDlQhh60s
         pvZVWvpNC4TKnprLfBFBzAIFyJQEpYYsYY8ISXBERVcuBe2zYyJav+sd6mDwGT1M+TIR
         9kRY7jO+ujjccfNhjE5ZL8FfCsmBEW4pJHt6tukFJ2Mq6BIFi0cKPNp3VjNwt28Dfc06
         37Mlk7Ir1J++skyPRNKl8EcVoSkN70wNfk+E/YTUBHiJ9GDSLIcB26eyp/kytpo7CMag
         nNsr7GMMF4eFKJcZDsZQETK9T7ISfaoxvB27gL4rhvruu4Ybp0uBVJsWyfk/nxFTuiYA
         lk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XSp6Q1v1/gx7cjG8OqE3DYLw7nKGGu6Wqxa+SjucNcY=;
        b=xZnZS1hV3L+wNehW6opYovG2FLG0YHaga30zK3KL5jbzT1bBzV9BNlZB2m3jWPk1AX
         LeDwrggNVf8e3C9Fol4+FlKuTgSIQieWqcok7f98rYpcwqR4/AWJ0JQ46/sSQv5nwkN+
         IqteH4+cutKMdVix1+lO07aS0KsZJBk2U/zxUZH3lzun7odhp6qzOLFZY6EM2Lfp7GJN
         Usl/f1gVZJPETLH93iLgICkyasf6tsf+UvTvojw+RlmZML1y9giBBXLEzKjCtCgF5+wy
         R53I4n2mAq/ktu+8ov3hdHE8Y9ix760XP27V6bRk0HxqvHgaP+WaveLH6T2hYfZ15SXO
         XWNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 060/183] kconfig: Fix expr_free() E_NOT leak
Date: Wed, 25 Apr 2018 12:34:40 +0200
Message-Id: <20180425103244.944360192@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714298817747000?=
X-GMAIL-MSGID: =?utf-8?q?1598714298817747000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Magnusson <ulfalizer@gmail.com>


[ Upstream commit 5b1374b3b3c2fc4f63a398adfa446fb8eff791a4 ]

Only the E_NOT operand and not the E_NOT node itself was freed, due to
accidentally returning too early in expr_free(). Outline of leak:

	switch (e->type) {
	...
	case E_NOT:
		expr_free(e->left.expr);
		return;
	...
	}
	*Never reached, 'e' leaked*
	free(e);

Fix by changing the 'return' to a 'break'.

Summary from Valgrind on 'menuconfig' (ARCH=x86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 44,448 bytes in 1,852 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 1,608 bytes in 67 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/kconfig/expr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -113,7 +113,7 @@ void expr_free(struct expr *e)
 		break;
 	case E_NOT:
 		expr_free(e->left.expr);
-		return;
+		break;
 	case E_EQUAL:
 	case E_GEQ:
 	case E_GTH:

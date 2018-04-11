Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49XEgfQKm6bnRLvX9ttEywhl/Al6Wr8q4mg2HbjDGYG4+JT3IsOufBhQ3BFqs/Fl6+vwMLt
ARC-Seal: i=1; a=rsa-sha256; t=1523473319; cv=none;
        d=google.com; s=arc-20160816;
        b=E+BvqsneIAwDmAP7f15SGWl+tOBsTl12HyKvbuPxS9ST6YYjIM7aR/rtlCgAAqf6FH
         tavEmWyP7nfMi72+1E85dJbNdkb3qWmnRWWbGuNcxj8HBYmuQkjzPS5MvdgLUDTnyXjF
         PsWcInQ4S4UNhnSpCxEtv04rtgVLX2oDIQAPEw91Yvs3znxvipYXRFZQNXYmk7kioAff
         KtlbotugcU0/QzNO081brtFFHru0q/odrrHTto1U0L79jBnfOfUgMGUS/5vA1H6pCbAj
         8lygQA4ogRpNDAp8vDZgOBKLjVQRZBHxJTclSrd96fsxj6hDEl7wCqSCAVIUHiitQ6hS
         hfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kOrEwwoQRytbDax/ftDB048dY7c9JHiI7RPdwDtqxN8=;
        b=lYwro/QgOBhM1ak4US+GCoplOOP/iqG8bYA3vpcUA//8edYBGh5gJSLn4oAmZ4UVvL
         Vpcf6hqEVDM39+eCz4vCltwikBvTPUrMh97IC90ydTKR8Y7TI9PrFiEPzUDOHJlySEL3
         6ReWoJ1C5s6528wHDlCgaOHUv91IgMzklOhv2t+x6pQxtfKJ+bfFvE4AR7ziTtGVOOPQ
         rCpGj8y3wQij5MCQdrSTbqSVWIsd7a3Z3R8Widi3z/mxGZCaRgDjXLcXtQdL7bURyUAt
         ZN16Tnlud3E+17ecHje2ZMHxzHGzqYAxWLD/vJ3GYaDSiQo6KLmF/eeAslyjtGjoV8B9
         XUqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 203/310] tags: honor COMPILED_SOURCE with apart output directory
Date: Wed, 11 Apr 2018 20:35:42 +0200
Message-Id: <20180411183631.308317946@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476235071053164?=
X-GMAIL-MSGID: =?utf-8?q?1597477559373323497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Jarzmik <robert.jarzmik@free.fr>


[ Upstream commit cbf52a3e6a8a92beec6e0c70abf4111cd8f8faf7 ]

When the kernel is compiled with an "O=" argument, the object files are
not in the source tree, but in the build tree.

This patch fixes O= build by looking for object files in the build tree.

Fixes: 923e02ecf3f8 ("scripts/tags.sh: Support compiled source")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/tags.sh |    1 +
 1 file changed, 1 insertion(+)

--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -106,6 +106,7 @@ all_compiled_sources()
 		case "$i" in
 			*.[cS])
 				j=${i/\.[cS]/\.o}
+				j="${j#$tree}"
 				if [ -e $j ]; then
 					echo $i
 				fi

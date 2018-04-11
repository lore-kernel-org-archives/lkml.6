Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48RQDxWCLXmcVRZuCwl1HTnwZtDuUfytfEeI+7lTlLmbOlGFHynsH5/7hnXTTVXD/lINzkD
ARC-Seal: i=1; a=rsa-sha256; t=1523472542; cv=none;
        d=google.com; s=arc-20160816;
        b=0H2xPVxuBY3HHR7tpNO1zgUMunGIrKySIjy8+FEsxsXbsjfqUudIvLFfBmUi5F14CJ
         FPY5H7OTjmvjBBLJkOlhDyeDdwW28csvroULwJBdPSfwVfWzQktHW35rFaFN3t21KXgp
         oAvxaDnQiKMEQ7En+cquR31ghFS63bKlYzey7cHABBwsGnMETNWOdhUI58ygj06sqLwx
         ohrP0jnpiKMOFyOpkH7zmjx2TzyP9uegetDF9EU1x0TmjxeOaam59Sc9SojcLEvrjMUf
         zPNBDHweagTm5La1ZShXtedBRFTZ6A4bjGExmeIDW13BTktC5D5WTOO3sjYpB4ok84QR
         8B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bWwLXLq0RcNFdMp/e31IeKPoFkaiP49mkrpp1x1iixE=;
        b=EUJdqUHlptIp2T1Lfq9Cpoe4g8pL3TxjoRusEMMe+8XtVNIasXpIN7LL7Pa4ROmssL
         Y0cnclufJELSEv2R8V/z53mKfYtowh0LdaaDcMchLUE/1Bp/9N2keYeiTCM5ouq4A4qQ
         D9CUEoKaqBrD7kBUwVBNY474slqOVpo3liH/AfC6kw2EJWoe9vSFVNotiJ6UoBFe5NXy
         qeD/4MirMLWOs2cKswHE4PR4f94ZO9vQizUeNQ/a6grFEewtKXnKwNMv5KXq0aXWOsnL
         k5BHWhgOOCOYMpD5OjQAx10LSGUT7TDqkiLanmxzz33rb6SYjv4OVRyr6WG1Wt8DE+UF
         iS9Q==
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
Subject: [PATCH 4.4 123/190] tags: honor COMPILED_SOURCE with apart output directory
Date: Wed, 11 Apr 2018 20:36:09 +0200
Message-Id: <20180411183558.955469394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476235071053164?=
X-GMAIL-MSGID: =?utf-8?q?1597476744025185226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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

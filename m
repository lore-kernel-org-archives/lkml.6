Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrVQEf/8381+VeQa4LM+XgIVsURfL/cCC1xng1dfhG1yqhJcEWDGTs3O+VRRknAev2U+pkT
ARC-Seal: i=1; a=rsa-sha256; t=1525116538; cv=none;
        d=google.com; s=arc-20160816;
        b=sSlIeKJKki+fQ7Lng98PF6AkuJQ5wQKybPzKUaph0pTgU5pPNGEJU4BVNNs3R7kwU/
         Oj989ZBE5/Ls22+aAa6ExcbfhE02AZ0gHPLa0hLO6x1C3HbbK6lj+GOVlBvljJ83D4lS
         BniYuzbbEuXJwq8RJrBOO8XAmBTL6N1Bz56IwYcsO3Sgpz6k1MhF69WQ95McFxpiojPM
         BGzHinADyZY66NrK5C7nAO71iBsZXnNU8XKyM9Qe1FwECIzV2NanSqW3I4AV894Vci11
         2j6MYHfqXQoLcnScOE3IP+5ZaC1sQ7NeevCOWIacXUAU7kR7MzKd9LX402A+gCsTbdDx
         L3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=GPDMPvP/TnFFrdXgOXbJ1w8GorGHxyii4uRNGh9lsYM=;
        b=Gu/BtbtLT20RKz/JqlwaWaFh9T1AIPwHyDRB3bn/u9YwCrs1unHlsT90TbXrjHDmrZ
         WhHbQ9CWMR75/wyRbbK5r5UVLbAzW3kFFY3zjmOmvYrQ/aM7sfbekxdQ5tqO+3wgV37+
         41gFqWucQJOJwz9lM64o4Wj38twTSOJeHUC2b/+J/wgWCNViAYGk+4hyvyXTGQ5B2UiF
         X+Vzcr5hBcpIJRIH1iHKZFkTam6hUdSzIRi/cicLHpia0buSohVOt8/kkvL4lSy1pAoq
         XBiPReZbouEjh9Rp0MXETr9bohwwCTLQ5alliPGLbieMWv4W+hoZuU/3LD9etpprZaD5
         NVCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48A422DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4.16 079/113] slimbus: Fix out-of-bounds access in slim_slicesize()
Date: Mon, 30 Apr 2018 12:24:50 -0700
Message-Id: <20180430184018.522697931@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200599496393275?=
X-GMAIL-MSGID: =?utf-8?q?1599200599496393275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit e33bbe69149b802c0c77bfb822685772f85388ca upstream.

With gcc-4.1.2:

    slimbus/messaging.c: In function ‘slim_slicesize’:
    slimbus/messaging.c:186: warning: statement with no effect

Indeed, clamp() is a macro not operating in-place, but returning the
clamped value.  Hence the value is not clamped at all, which may lead to
an out-of-bounds access.

Fix this by assigning the clamped value.

Fixes: afbdcc7c384b0d44 ("slimbus: Add messaging APIs to slimbus framework")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/slimbus/messaging.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -183,7 +183,7 @@ static u16 slim_slicesize(int code)
 		0, 1, 2, 3, 3, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7
 	};
 
-	clamp(code, 1, (int)ARRAY_SIZE(sizetocode));
+	code = clamp(code, 1, (int)ARRAY_SIZE(sizetocode));
 
 	return sizetocode[code - 1];
 }

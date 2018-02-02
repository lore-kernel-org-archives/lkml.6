Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224wwVB80wtTRw0zm87JeA3ncztNG+pDB7P+UAn+XYzoCjiYMJFE0T9eofOe4J35ULwamsd1
ARC-Seal: i=1; a=rsa-sha256; t=1517591525; cv=none;
        d=google.com; s=arc-20160816;
        b=U5Sdksl1u14u5mQvaeEZ6qcR+BuMQNscMa6fbtFI5W92x/UTgBJnTr60HGY8GVFFK0
         XzjpItlTQ3LyrHJW/JrgeUui7DYGE/WKsOXrT9SzxMncs72x5etJ599hvXjobmDQrl93
         q1sBI6AvfzIuwZYbj02Zaed/tyl441FbrDwjjuSXnQYMfw1/MunohPO3rtzbPeJ1wZri
         rpGlCpLo2ouH/zdy7HVc7u95tFMtahWGDqXiiIXnN7DRhehZC/LMTiVXVJaYGmA7ff4R
         lChLNRvZU4BgyTi2XtAJyWTZDfIx9T1vbqQcrA5I8HWyfUiJEAIWGi7v/6INU0gUW5DC
         Icyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2xSc7bMxTw9iuqgET+REEXzpADpOwIVHZ/JPIkODLAM=;
        b=SpgA6Ge5/HpZlZa+ZXMrNJ/1lvLAPYa2Ib6kerQWch7h9tobE4JTWqQgJwhEIqKudq
         hXC7URjWPUdxrSXSFF5F0FyZsx/ZyTgoCMKP0TUtzUcZZNkd8cafQKy4DGnv3I6ApMuq
         TITndfVK97BBkmkN7++SwK9/lyueAsENG+XqFoHmmDn5uPoqlhiUarX8/mnrIb/S77HC
         lhs3weUhkwM4wqQZk6LedYotFf48osLo20lYvtP2mR2aN/Qn8tu1Wok5yeoV0LF7yX8S
         TwS7d1aYMC789KP9RZuWvbLj0fdSfAg/iugG4/yjcEwHeLDSKdLjgSYrNhfc0g7ENCfG
         4pDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 110/156] drm/bridge: tc358767: fix AUXDATAn registers access
Date: Fri,  2 Feb 2018 17:58:11 +0100
Message-Id: <20180202140845.152664242@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309622015901921?=
X-GMAIL-MSGID: =?utf-8?q?1591310051643158498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>


[ Upstream commit 9217c1abbc145a77d65c476cf2004a3df02104c7 ]

First four bytes should go to DP0_AUXWDATA0. Due to bug if
len > 4 first four bytes was writen to DP0_AUXWDATA1 and all
data get shifted by 4 bytes. Fix it.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510073785-16108-6-git-send-email-andrey.gusakov@cogentembedded.com
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tc358767.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -318,7 +318,7 @@ static ssize_t tc_aux_transfer(struct dr
 				tmp = (tmp << 8) | buf[i];
 			i++;
 			if (((i % 4) == 0) || (i == size)) {
-				tc_write(DP0_AUXWDATA(i >> 2), tmp);
+				tc_write(DP0_AUXWDATA((i - 1) >> 2), tmp);
 				tmp = 0;
 			}
 		}

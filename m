Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtG0ifv7lGSAVjs8ey5xDYMUbUD8J6cLRR1sVdxuil3UxhX/MzmceXI3UyJhF+1iJYp6ITK
ARC-Seal: i=1; a=rsa-sha256; t=1520451608; cv=none;
        d=google.com; s=arc-20160816;
        b=zIgzxB/Ot6rs2pcSFlXogniejITkPo6bm3JP/4yg52Zra9WUGzOrlmeBdZK+zxlskV
         k95SACOqjLI6/UE2peRYjYRuVGDWjWZIPL+peXGNNF2fcZzTp1lBh5+WWvOm7tifKcha
         zhocEFGMrkEHKMX2NIro0xplgWvNomW5WtNmHTKAmG6MTorV++OhuEabwV3F3Yafy5/X
         +mFrmw8105xhVvj35o22IPYXVscWQ7rLUrB4b6xvj0w7ZHzu6aYSvYxIUICUtH+6dH/w
         GoZBZXBZhxmFyg3pfcSzALZGkOrB5pxZ0/OOpeCZyzXLJs3GnQCrgawdSetk5gHlMSFW
         KAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iyW5DNC35DKcra97H8djESxRuQLpmoIp2C577bnp/ME=;
        b=i/ZQP5RelBBAr/vLcqGDDzB0E3/1YbJFnn2abcnjcI+K/zFXQY+rYfTH4OwQVa6Eye
         zPrabyNp9o5fMTIpkLL314dp8SfdFeDnDPAy9u6OMtt+OjSJGR2jXle93FrPA2mt/B0i
         WE8wZIwSTcHy0nGngv20qkP+JRmG3rOHIvOVrGnf6wqwfU1vQsHVZWPE1Fc/n33cl4Sb
         BafFCDd+mFrEosC8tVWvLSzSP0wiK3eikvHB+m+O+bvht8MEASE8VOLwfI02z0jHyEwa
         +avknlO4WQDFuKhVNu1a9YdXHwdmiQgef7+4PgzKa88kuY2YzvqkTrYTzE4EXZ7RXTtC
         36QA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 019/122] mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias
Date: Wed,  7 Mar 2018 11:37:11 -0800
Message-Id: <20180307191732.117591902@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309066066917248?=
X-GMAIL-MSGID: =?utf-8?q?1594309066066917248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 325501d9360eb42c7c51e6daa0d733844c1e790b upstream.

The hs_timing_cfg[] array is indexed using a value derived from the
"mshcN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 361c7fe9b02eee7e ("mmc: dw_mmc-k3: add sd support for hi3660")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc-k3.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -135,6 +135,9 @@ static int dw_mci_hi6220_parse_dt(struct
 	if (priv->ctrl_id < 0)
 		priv->ctrl_id = 0;
 
+	if (priv->ctrl_id >= TIMING_MODE)
+		return -EINVAL;
+
 	host->priv = priv;
 	return 0;
 }

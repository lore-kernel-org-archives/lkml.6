Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuM9Ipq1468kZQzWDj3xwIGTpeP+6tM8pJqSJAcXZOVF396GggcGgEg9eYacYFEFk0QV2sX
ARC-Seal: i=1; a=rsa-sha256; t=1521215017; cv=none;
        d=google.com; s=arc-20160816;
        b=wb+ZaRV+q5IQx0mOY3TE7NvWRsqu3xWrUGO7rE+PgM7NdUAFJV8I+XKs7ODgK+L7Ly
         LS8OfcMuH3ZOltXBUJ7R+7DuZzl84oonDNhtOXLXYG2fNobmq/XylrUM4+OSh93vjWQA
         VpnCDK1/YhB4cBgvI8YEnDquDh2ObEPI8AZD5GAI7vOaVLmRq5SAWuLgaKhCguB/pUql
         ZOOkmIlyAXeH4cFcKrCMzzXajB8fLrMn01LNk33UyMTqwWmNgSRiV9DITkTf4WFz8jiE
         XFjI9J/6Jw4QmJDLfQ1r7y5ady53eKxZQWNIk+HP5dm91sEJUWNX+3O6B+EtvdU6hoKt
         RH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5+hzjfk3OWPjvJANd4HPmv5XnY+WjrPxfspbsMQ3eSQ=;
        b=Y+cloOPAa3NM6sT9SeEj7FvIPXGdisaODDgo2QTNuN9K7oor6Ikli7sTPvyJxRb1v9
         qq7UICPYdrX9K6TxuDuByTd3g483im1RIPipXT/zTrcH/8zjLlP5NJtR4dMsZApXZ+z7
         /3J41UklU/TYDUWujmO4UVTt9kf3eIzGPRKubmBWQ9WVfcxzEIrOpRAkcitPUrXoxMjB
         rRPWGwtH/WTiAEjUQ5XFTDhrbtnsu2QjP2t+U5TgviJGaRnxThjEaNIx2Bn5O5bFNKOJ
         HkNRO7hX8Ev14avKq82Onm/AnHSBBNAmiA2I59Jm/M4QhaLo28i12VqnqYhjKq/srIx+
         qaOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Bogendoerfer <tbogendoerfer@suse.de>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 098/128] bnxt_en: Dont print "Link speed -1 no longer supported" messages.
Date: Fri, 16 Mar 2018 16:23:59 +0100
Message-Id: <20180316152341.435859136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109183231827266?=
X-GMAIL-MSGID: =?utf-8?q?1595109557737733394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>


[ Upstream commit a8168b6cee6e9334dfebb4b9108e8d73794f6088 ]

On some dual port NICs, the 2 ports have to be configured with compatible
link speeds.  Under some conditions, a port's configured speed may no
longer be supported.  The firmware will send a message to the driver
when this happens.

Improve this logic that prints out the warning by only printing it if
we can determine the link speed that is no longer supported.  If the
speed is unknown or it is in autoneg mode, skip the warning message.

Reported-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Tested-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1706,12 +1706,16 @@ static int bnxt_async_event_process(stru
 
 		if (BNXT_VF(bp))
 			goto async_event_process_exit;
-		if (data1 & 0x20000) {
+
+		/* print unsupported speed warning in forced speed mode only */
+		if (!(link_info->autoneg & BNXT_AUTONEG_SPEED) &&
+		    (data1 & 0x20000)) {
 			u16 fw_speed = link_info->force_link_speed;
 			u32 speed = bnxt_fw_to_ethtool_speed(fw_speed);
 
-			netdev_warn(bp->dev, "Link speed %d no longer supported\n",
-				    speed);
+			if (speed != SPEED_UNKNOWN)
+				netdev_warn(bp->dev, "Link speed %d no longer supported\n",
+					    speed);
 		}
 		set_bit(BNXT_LINK_SPEED_CHNG_SP_EVENT, &bp->sp_event);
 		/* fall thru */

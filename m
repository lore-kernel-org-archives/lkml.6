Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48c9AUEUdJck0Pb1ONlPvYW2VWhdz+8Z7vFxl5qyuXCpZ1AMjrmZuL9XOcO98eDrBfOjALX
ARC-Seal: i=1; a=rsa-sha256; t=1523472610; cv=none;
        d=google.com; s=arc-20160816;
        b=RhzIhk6JIz9hZ7Zycgj0gdBVS3fmTeRfHEhoFV+ru63IPpNCMIME+Zg3laKD4d5Q7g
         eToW1MZE5ogCFBiXqBVHVsMZuEhDI7aVdKjZIUWTPBEftHN5LwRhigGHwcgN1sWf/MxJ
         +LInVHaZ1RguOXNKCcFjlqQNvK7NiHHD0+5X9MgHDBEyWPu2csEg4+wQ8Al+cDJ5J3eE
         rRVDMi+3n2tkQpnNrA9cXrRCAn8zAvcM+aXKOcK01IDS814VO1nF+qHMSiq1cj0VA1r8
         4JxalFaCQhS9OZymP98OTYFnFQW9W/NLR2GHbL1RRMge7D+UVKWk9K+gjmmsHgOdVTC8
         5gGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vsvph3q9iQWnpN0yj2Z+Fz9i8oLlbPsnzjP6UxS7BM8=;
        b=mrwGNOzAsvl/5GnMC92GhHFOyCecZ1H3R56L0Vjpsb8Fft7tHuaMMqgS0LKxZ4b7iD
         bJId3qmDdmgv20e+hs99jswZWSbepd6kv1yuXrcwP6kTslzkbICwHBZ8WkokPPq3uWCk
         36dJSoPUjs0eLcIlHiAPrwbLiiFzHhLutLElF+4IQbXrJp83Vf0+iQJ21YlrTsdH7D7p
         RG6BXg3BdxCfrOdFCnGtJT7GeRGGclnbuAqvtDMcL7dif1aRJn3x4+EHv3kb3j7MvGS/
         OPRzwWhVCDhqe5PiMBhcYLhRVu+GfwQzmLko3g0OFz0liRmx7iAw+bBB5ggUUr9UTbl3
         vdxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 148/190] vxlan: dont migrate permanent fdb entries during learn
Date: Wed, 11 Apr 2018 20:36:34 +0200
Message-Id: <20180411183601.286565742@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476386416293891?=
X-GMAIL-MSGID: =?utf-8?q?1597476816202537662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roopa Prabhu <roopa@cumulusnetworks.com>


[ Upstream commit e0090a9e979de5202c7d16c635dea2f005221073 ]

This patch fixes vxlan_snoop to not move permanent fdb entries
on learn events. This is consistent with the bridge fdb
handling of permanent entries.

Fixes: 26a41ae60438 ("vxlan: only migrate dynamic FDB entries")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -962,7 +962,7 @@ static bool vxlan_snoop(struct net_devic
 			return false;
 
 		/* Don't migrate static entries, drop packets */
-		if (f->state & NUD_NOARP)
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return true;
 
 		if (net_ratelimit())

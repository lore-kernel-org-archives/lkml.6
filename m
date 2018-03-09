Return-Path: <kernel-hardening-return-12290-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtvmxifWzxEIhbSm52oXEGrXLcmGwFcRjqXMq/hoYCVEULXaODC89qzz2EIugFTj4vd9fqw
ARC-Seal: i=1; a=rsa-sha256; t=1520566582; cv=none;
        d=google.com; s=arc-20160816;
        b=hUwrgH4VgtuMy0c4BebGqcQMTWHDeA7b/u9QByPzBQ1i0GdpH5ZbJvkcMhx2vfsQc8
         T8xGFwLDpQzkDCrH98tMv/GwpIeNFCkcfvB2AqWgtZzu5KpWMCQ70W7ppWXwqxmJPVrm
         dI3OyPbXTt1w58+FWjoitrrvX9/LcrRGklQ7+gNImhbm5PcD9AY9bUMFJn3bM85IlzCG
         8V3fExwwOy6espEYLR9Wn8WK3FZY+bJHT/Sc3/WlYhZxA8l54+a2k5ZYA+d4cMUmu7tQ
         xq3GH7uMzVHWIDxwFEmtGzkrXjqZz4mZAvgHBlquAcj5Br6AFePPEDYCrGIX2NvQlsQZ
         xJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=bFGq9LT97zGditzQAX1mbCyj5hIYwXl8ey6GfgUfr/U=;
        b=SKBIZ/3MRwlEgaRbXTQyNNJXFCIEuf48LTCGRLFP8CLUM19w5Tr6+oU/2t9PYu0wU/
         9REJt+FmxhulYrxYxlQxAHr2ONndz+ZtKIbYk6Uv09E+0Cn75r1T1vGKvGjZq4Fpfu8I
         tYC3NPUUcp4qtl+aLijA2lxZmxJ9R2+ooWePAIulL3rcMKNhuo5M327Rhm5s2MMUGtGU
         tfu++qCp/3H0GKbKTzenX8LwKW07lcWsYdVS+OPgEziyCkOJGSmwLkn8a2vv3txK/bwu
         GJ8v6aZLmO0nmbPWAeST+1ixMrEwntQvowWJjDNrNSb38KK/G3+7gSAt9dUyjCn861sX
         Ms3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=nUAYBCtB;
       spf=pass (google.com: domain of kernel-hardening-return-12290-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12290-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=nUAYBCtB;
       spf=pass (google.com: domain of kernel-hardening-return-12290-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12290-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Tycho Andersen <tycho@tycho.ws>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	dm-devel@redhat.com,
	kernel-hardening@lists.openwall.com,
	"Tobin C . Harding" <tobin@apporbit.com>,
	Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] md: get rid of a VLA
Date: Thu,  8 Mar 2018 20:35:44 -0700
Message-Id: <20180309033544.22509-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594429624503738722?=
X-GMAIL-MSGID: =?utf-8?q?1594429624503738722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ideally, we'd like to get rid of all VLAs in the kernel and add -Wvla to
the build args: https://lkml.org/lkml/2018/3/7/621

This one is a simple case, since we don't actually need the VLA at all: we
can just iterate over the stripes twice, once to emit their names, and the
second time to emit status (i.e. trade memory for time). Since the number
of stripes is probably low, this is hopefully not that expensive.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Alasdair Kergon <agk@redhat.com>
CC: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-stripe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index b5e892149c54..cd209e8902a6 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -368,7 +368,6 @@ static void stripe_status(struct dm_target *ti, status_type_t type,
 			  unsigned status_flags, char *result, unsigned maxlen)
 {
 	struct stripe_c *sc = (struct stripe_c *) ti->private;
-	char buffer[sc->stripes + 1];
 	unsigned int sz = 0;
 	unsigned int i;
 
@@ -377,11 +376,12 @@ static void stripe_status(struct dm_target *ti, status_type_t type,
 		DMEMIT("%d ", sc->stripes);
 		for (i = 0; i < sc->stripes; i++)  {
 			DMEMIT("%s ", sc->stripe[i].dev->name);
-			buffer[i] = atomic_read(&(sc->stripe[i].error_count)) ?
-				'D' : 'A';
 		}
-		buffer[i] = '\0';
-		DMEMIT("1 %s", buffer);
+		DMEMIT("1 ");
+		for (i = 0; i < sc->stripes; i++) {
+			DMEMIT("%c", atomic_read(&(sc->stripe[i].error_count)) ?
+			       'D' : 'A');
+		}
 		break;
 
 	case STATUSTYPE_TABLE:
-- 
2.14.1

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvLQFO5QNFAfgUR1QJKfWmv869nNGW5AvrvYFmgWPsPfAfLZJvCKaDs5UfQIcnQHO/4IMkr
ARC-Seal: i=1; a=rsa-sha256; t=1519981458; cv=none;
        d=google.com; s=arc-20160816;
        b=MtK2J4O4XoegHamlO2ktuoRJsuu0/RkCQ25C6J4X863K1raf3HhkryWBvwnu96N3qv
         HIOCw7z6XrJ4XNWH7yBFYEK1C1aMkblOrm35F3uorJsdaNFc5t+CmuMe0D9tIt14ajDz
         nRx4Qngo9CsBdBkEDUKl+NYZc8dOVaB/sASMY+KDwwYHMdLsPPs93TsQY/4PlQvW8POU
         oTqUWjOA0hJPWYyzE/6TjUm13q4GdnC/Pp4BcLp/GMApKiVi6es3xE0RUMJksWrkauj9
         GgJgY2sl6XrQIKNOvO59htGNcaWT3kx/ueh9yreJ/vcFE2+qFaoGWo7/dvaio61AdhcQ
         d7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+LuQ86/q4s12pv6AgXeoFq9SU+9HzTieoyXRaHm1CGk=;
        b=IMozvI0AQ+7bsgIH8gfRt60OXBJTj4sh8RtqDDM3F0s4ftqh7rzceHham5/u4yMyYd
         yB6mvyyrajJ5ypFi4uXrtigstGEW6umdlup55hn6QTZaxsvMtc/o7X4gJIx2LXdCfrnf
         xuB8+1rHDV9/RmewLWJstwY9MQmJ+Fs4k3obnOROuitk080xtHgCg5c/BNfb2w9dufwQ
         Nu07wRkRTgUPBuPYZ4m9wlQ+VDwMxQcP7NApaYgPgaq7aNFILf2NVgWYR/N56Qmbkxkh
         rmNVLDQ0RJNwTgK6hGZdOPkWoYq90C0r9Y76An8BJhDmafufKUma0NHaVxHqEaZeKDCv
         b/ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Venkat Devvuru <venkatkumar.duvvuru@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 096/115] bnxt_en: Fix the Invalid VF id check in bnxt_vf_ndo_prep routine.
Date: Fri,  2 Mar 2018 09:51:39 +0100
Message-Id: <20180302084507.726620179@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815495001614943?=
X-GMAIL-MSGID: =?utf-8?q?1593816077567029478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>


[ Upstream commit 78f300049335ae81a5cc6b4b232481dc5e1f9d41 ]

In bnxt_vf_ndo_prep (which is called by bnxt_get_vf_config ndo), there is a
check for "Invalid VF id". Currently, the check is done against max_vfs.
However, the user doesn't always create max_vfs. So, the check should be
against the created number of VFs. The number of bnxt_vf_info structures
that are allocated in bnxt_alloc_vf_resources routine is the "number of
requested VFs". So, if an "invalid VF id" falls between the requested
number of VFs and the max_vfs, the driver will be dereferencing an invalid
pointer.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Venkat Devvuru <venkatkumar.duvvuru@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -70,7 +70,7 @@ static int bnxt_vf_ndo_prep(struct bnxt
 		netdev_err(bp->dev, "vf ndo called though sriov is disabled\n");
 		return -EINVAL;
 	}
-	if (vf_id >= bp->pf.max_vfs) {
+	if (vf_id >= bp->pf.active_vfs) {
 		netdev_err(bp->dev, "Invalid VF id %d\n", vf_id);
 		return -EINVAL;
 	}

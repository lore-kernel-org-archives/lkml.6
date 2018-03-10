Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuIrXYbpHfTSL7CxtHvLh7dNSPp9j36zIIAHV/NqSQybk91aAOmhqNIWNMBTsI3FpwfkGUj
ARC-Seal: i=1; a=rsa-sha256; t=1520641355; cv=none;
        d=google.com; s=arc-20160816;
        b=A5SxVxo7tb5oXW4xNYwbLOLltveHrdYCIGVwRpAAHbm6PMpL8vm1y7pXwvaAP6gTtl
         EnOHSojal7KIUSRJJrAa/RCoPS/yFSWmPl7uHDQYngMsEe9b4dEvPB5IGhHSH/FojEFx
         /ztKJDGO1ewToM2OmpOwrH4AECvbU5blHhLfH+3tOwL3z8eZi8joRAKA+DqLn+dO+Lks
         ABy3MbY21K6sO8b7hTWTA4NdJgggIrWHZ41ZakxiReSoVa45iMdW5g1JUby4S6zx5QOA
         UqF2f9oOeKXC+zUCZojJgkdmoXrrGBGrVWnls2HxI6aqrcxo+9NbEGuposfo88jAfzpq
         xa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iLbLU9T/oZHglQ+cXqGBKoA+oZDvfHNT2rdZK7rbPH0=;
        b=sgHfzQHQeimL2vUPiH5mHM3tIcCBk38bcscy0Sfm7iD6I3/1+Z8hAWHyhetelva7UY
         a9QpJqaDD3+bbZbvoFD/nfvtk5mCZowA8yA1064Z2Xli/9eOxweotVsIZP0k7haF2DeP
         0GhSTf+qy+SMOwZbP4iNZ+k7yom9TMedOxq91VKXqkuVbaMMHiXDvUitu5rpJwqSyjt9
         OSntv5oj7tFVZ8SCuo4rkov+KDcjA7lvB69IPNT888HJHDyj2umqulWWBYJ8RVjI1wC7
         +Uoc+gPd57DXT0yS+Kn1aCcI/2DMxIUag2h33+KZst1RcfMMs7B5R1FmDfPsMz5gwlbr
         8lBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 53/65] s390/qeth: fix double-free on IP add/remove race
Date: Fri,  9 Mar 2018 16:18:53 -0800
Message-Id: <20180310001829.247586802@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508029983156066?=
X-GMAIL-MSGID: =?utf-8?q?1594508029983156066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 14d066c3531a87f727968cacd85bd95c75f59843 ]

Registering an IPv4 address with the HW takes quite a while, so we
temporarily drop the ip_htable lock. Any concurrent add/remove of the
same IP adjusts the IP's use count, and (on remove) is then blocked by
addr->in_progress.
After the register call has completed, we check the use count for
concurrently attempted add/remove calls - and possibly straight-away
deregister the IP again. This happens via l3_delete_ip(), which
1) looks up the queried IP in the htable (getting a reference to the
   *same* queried object),
2) deregisters the IP from the HW, and
3) frees the IP object.

The caller in l3_add_ip() then does a second free on the same object.

For this case, skip all the extra checks and lookups in l3_delete_ip()
and just deregister & free the IP object ourselves.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l3_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -323,7 +323,8 @@ int qeth_l3_add_ip(struct qeth_card *car
 				(rc == IPA_RC_LAN_OFFLINE)) {
 			addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			if (addr->ref_counter < 1) {
-				qeth_l3_delete_ip(card, addr);
+				qeth_l3_deregister_addr_entry(card, addr);
+				hash_del(&addr->hnode);
 				kfree(addr);
 			}
 		} else {

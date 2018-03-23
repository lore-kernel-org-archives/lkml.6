Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvgg9v1RynJ4Xagq8Wkpawhc102ZA8Pr2Em+YG3SbLj9SwSSOz9BgNLvqjpX7S1Vy0+o+Jf
ARC-Seal: i=1; a=rsa-sha256; t=1521800292; cv=none;
        d=google.com; s=arc-20160816;
        b=DZw2WOdBDwD3ngZV7YZbCRDJZ1LWC4DFvX5jbN8p0Tp/WVqnwkvin+F7/21A6quujO
         70jLQB0wn3GuHknBdMhEVc2HoRtbABIev86oiU6GItv+NoCT9TbVo79WYYfgbTXQ1Zu2
         A5Fkn6Znjo0dikm4aRcwW1iK5zXK7WyS9v7CaSa8dRCyoHl+U9ZVNQNRs46Nnv1YfOrS
         9TWz55C4TrDmehDFPh/vwGIGknTnDrD/z5wxSP50OfW6GvXyaiS1Qa5bitPjRSD32sBM
         Cw85Gkt+1HFGAVIdZFty0cjO/iRUQQdMHy9veyDHF3oDgc8YiUfWcl2xCE7988ksJVZA
         rapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k1DBlTqSGAI97IHIDsSAvvW3gzDJ4JQ62RTSjgJlG78=;
        b=o1IUZHHCQzm5+qY/hL9j9TwRAc4XVh2FlaKC+O74EQQ4Rn0HMkMLgoEef0VjUmnEwe
         Y+3TBf2dGqVyfZpy5Rf+svczS5CXnP90iLQ8eJXJjy6Agv1CE8koB39o3FSJINcCv3XU
         VlZmnhy6qQX6Rvra7rqoRuwkt7OlYClFVlGSMhqJhOy4WTnfZ2axBkthWMqbHa/0zMsH
         1qa6TbC57uvEIyhuTKEWnOZ0Tg6Qin+0bpXQpl79C7zok0KPuRvphi5VZGUTNjj8kvIN
         rQAuoiy+6C2YPbEd3k6Kk2YaSqPG137suVyBndmZZ7LTjydJzmQwl9JkmM2ZSDTBij8s
         h6Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Feras Daoud <ferasda@mellanox.com>,
	Erez Shitrit <erezsh@mellanox.com>,
	Alex Vesker <valex@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 17/47] IB/ipoib: Update broadcast object if PKey value was changed in index 0
Date: Fri, 23 Mar 2018 10:55:08 +0100
Message-Id: <20180323094248.865327702@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722532065984207?=
X-GMAIL-MSGID: =?utf-8?q?1595723263645134527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Feras Daoud <ferasda@mellanox.com>


[ Upstream commit 9a9b8112699d78e7f317019b37f377e90023f3ed ]

Update the broadcast address in the priv->broadcast object when the
Pkey value changes in index 0, otherwise the multicast GID value will
keep the previous value of the PKey, and will not be updated.
This leads to interface state down because the interface will keep the
old PKey value.

For example, in SR-IOV environment, if the PF changes the value of PKey
index 0 for one of the VFs, then the VF receives PKey change event that
triggers heavy flush. This flush calls update_parent_pkey that update the
broadcast object and its relevant members. If in this case the multicast
GID will not be updated, the interface state will be down.

Fixes: c2904141696e ("IPoIB: Fix pkey change flow for virtualization environments")
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -955,6 +955,19 @@ static inline int update_parent_pkey(str
 		 */
 		priv->dev->broadcast[8] = priv->pkey >> 8;
 		priv->dev->broadcast[9] = priv->pkey & 0xff;
+
+		/*
+		 * Update the broadcast address in the priv->broadcast object,
+		 * in case it already exists, otherwise no one will do that.
+		 */
+		if (priv->broadcast) {
+			spin_lock_irq(&priv->lock);
+			memcpy(priv->broadcast->mcmember.mgid.raw,
+			       priv->dev->broadcast + 4,
+			sizeof(union ib_gid));
+			spin_unlock_irq(&priv->lock);
+		}
+
 		return 0;
 	}
 

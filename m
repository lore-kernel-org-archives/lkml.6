Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+7a3Qnk+BW9lTgcCLriUJnPeojEgIAGA8E4aRfLI+qG9fWvWwz6LoxyDWuijP1oz5m5JCF
ARC-Seal: i=1; a=rsa-sha256; t=1523472965; cv=none;
        d=google.com; s=arc-20160816;
        b=XNGCr2vVIKKjbVS4P9dZgJya5K5h9Xg2IxJd27ABO5NSSrIsv9YDPc7gXsEfwX6e+v
         BgskHyou6+AWk/XW2GnNvlyOtqcwQD3LpCIiFTEMwK9GCn31qJ1XKBuQiLH6CsmkuYYl
         ppR3HRatPmoNSD4oUxkM/QqayyhIRbIMOkyJJQR/eiQRAdTUxgSKYy/ZcAkBQqsSzHgY
         p7yj38WZY8gIEAW75E7c8YRtJKyvqSNpCW3Y+dKLjHz3XyG9w7VpEId8CUrI6L8rx34I
         p4hdz91kkSBy9SXlbVckIuWm/BMdu6ihfPGXspR4yCJY8g0/GbEIumJSzEy2EIqXrM0n
         sqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yNnH3MqS3OQr2GnM8qgiIWZ34QWUaFn9gm/p9Uqmbkk=;
        b=dRlIP8xAneFIQowDprhrVdOxzP4RfqUDyrnqP6952Ra/+Smvx+b8g4NW05PCiOqWre
         xoxPNQzSbKk/H3cx9DVPu6dkXjwn76klhdM1rZS10mqrUUvXbMtko1AaomdPETNWY91g
         k/tgr9hyj+6n2UvmkwcSdPQwWHXMgr+3/MseRo8z4hin9PlIVczQhOazCwV9lQTTKocJ
         jNBhYpCiOXv9lpxdMGgqYvwJvEAv5z0gS35uXVWhjhFsyPLJH8rThoE/E7CnBDA1ucq9
         w/shyFYMj+qT0Ox4CUcRwLLc4KEcxRKBnD4lJMan3HS7OtOGw5ceiKO9gYTQJKy2IdJr
         pDmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antony Antony <antony@phenome.org>,
	Richard Guy Briggs <rgb@tricolour.ca>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 081/310] xfrm: fix state migration copy replay sequence numbers
Date: Wed, 11 Apr 2018 20:33:40 +0200
Message-Id: <20180411183625.776690297@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476127582157503?=
X-GMAIL-MSGID: =?utf-8?q?1597477187936551216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antony Antony <antony@phenome.org>


[ Upstream commit a486cd23661c9387fb076c3f6ae8b2aa9d20d54a ]

During xfrm migration copy replay and preplay sequence numbers
from the previous state.

Here is a tcpdump output showing the problem.
10.0.10.46 is running vanilla kernel, is the IKE/IPsec responder.
After the migration it sent wrong sequence number, reset to 1.
The migration is from 10.0.0.52 to 10.0.0.53.

IP 10.0.0.52.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=0x43ef462d,seq=0x7cf), length 136
IP 10.0.10.46.4500 > 10.0.0.52.4500: UDP-encap: ESP(spi=0xca1c282d,seq=0x7cf), length 136
IP 10.0.0.52.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=0x43ef462d,seq=0x7d0), length 136
IP 10.0.10.46.4500 > 10.0.0.52.4500: UDP-encap: ESP(spi=0xca1c282d,seq=0x7d0), length 136

IP 10.0.0.53.4500 > 10.0.10.46.4500: NONESP-encap: isakmp: child_sa  inf2[I]
IP 10.0.10.46.4500 > 10.0.0.53.4500: NONESP-encap: isakmp: child_sa  inf2[R]
IP 10.0.0.53.4500 > 10.0.10.46.4500: NONESP-encap: isakmp: child_sa  inf2[I]
IP 10.0.10.46.4500 > 10.0.0.53.4500: NONESP-encap: isakmp: child_sa  inf2[R]

IP 10.0.0.53.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=0x43ef462d,seq=0x7d1), length 136

NOTE: next sequence is wrong 0x1

IP 10.0.10.46.4500 > 10.0.0.53.4500: UDP-encap: ESP(spi=0xca1c282d,seq=0x1), length 136
IP 10.0.0.53.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=0x43ef462d,seq=0x7d2), length 136
IP 10.0.10.46.4500 > 10.0.0.53.4500: UDP-encap: ESP(spi=0xca1c282d,seq=0x2), length 136

Signed-off-by: Antony Antony <antony@phenome.org>
Reviewed-by: Richard Guy Briggs <rgb@tricolour.ca>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_state.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1246,6 +1246,8 @@ static struct xfrm_state *xfrm_state_clo
 	x->curlft.add_time = orig->curlft.add_time;
 	x->km.state = orig->km.state;
 	x->km.seq = orig->km.seq;
+	x->replay = orig->replay;
+	x->preplay = orig->preplay;
 
 	return x;
 

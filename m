Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49k6Rl7prFcogEnZRZmREVlkJt7W1QEALPxfS/WNdwtRkUar5XbzHgF3CJEgmFkRn8HXRrf
ARC-Seal: i=1; a=rsa-sha256; t=1524652885; cv=none;
        d=google.com; s=arc-20160816;
        b=Bk9NV6i2LK8fxEC8N8GUYQn1gVpguAa9U24gDA6vby6Tf9wA2qoExUBx+XF7Pc9Ij0
         bomnT1Lo6BZo7QSyKbj5FBBSF2nJQ+LGAUZWubWFQJOTerhe/MIhii0qLq0g2/duONLW
         9CDlPXNYYg5WNkURItulfYZcXlWR5PCtDrL9RvUH2UeQMSNbXmrWBrw2111myFmMCfyH
         Z7Fr/C8tP2lSh9r068PCVvi+MKkoXodaRxap9BTxsL0DVw7stJTKoHgieJSXHhtLSFIQ
         K5L3NcGcQtz9KO8WzsmONPUj8ZL7aM5G4pMSDQVyppq0qpo39S+oeHbZyW47KMCzmXE+
         S/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cIlpWTopS+GpTeU1QMdyC0I+fB5wJf5ZiNbB0ueTdgs=;
        b=xb54+RHJrVwr6Ll2CvP326PXR6Dy+QR/GPq89RMCMIrORX4Re4A2phYlCm9N2Zgf6e
         994vyNPp3JEWUSyrVIhVRQv31Iw1oWeBIcO6K1hCXtk+QgO33+7FC1KZqauwLi6Zs48g
         4g1lFT10asAuUoE8YjBKx4zMcWHihdvUgOyrEkoRemirQuFpUl8EjncYv77I8h8qXobX
         TSO7rJRhzkedLDfzdwfdKx+cG8uCD5nvl6bd5VmrR2/yPYWpLRHiXjfbBdhMVJW9ULOl
         hzr+5IGSz6AhYiLDKdGP6WLl4wIaUD0WKQBFw1BlWWysguqmuMBPG5FGGU0guTQDj6Ce
         OIcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 104/183] tcp_nv: fix potential integer overflow in tcpnv_acked
Date: Wed, 25 Apr 2018 12:35:24 +0200
Message-Id: <20180425103246.634702642@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714424080015626?=
X-GMAIL-MSGID: =?utf-8?q?1598714424080015626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>


[ Upstream commit e4823fbd229bfbba368b40cdadb8f4eeb20604cc ]

Add suffix ULL to constant 80000 in order to avoid a potential integer
overflow and give the compiler complete information about the proper
arithmetic to use. Notice that this constant is used in a context that
expects an expression of type u64.

The current cast to u64 effectively applies to the whole expression
as an argument of type u64 to be passed to div64_u64, but it does
not prevent it from being evaluated using 32-bit arithmetic instead
of 64-bit arithmetic.

Also, once the expression is properly evaluated using 64-bit arithmentic,
there is no need for the parentheses and the external cast to u64.

Addresses-Coverity-ID: 1357588 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_nv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp_nv.c
+++ b/net/ipv4/tcp_nv.c
@@ -327,7 +327,7 @@ static void tcpnv_acked(struct sock *sk,
 		 */
 		cwnd_by_slope = (u32)
 			div64_u64(((u64)ca->nv_rtt_max_rate) * ca->nv_min_rtt,
-				  (u64)(80000 * tp->mss_cache));
+				  80000ULL * tp->mss_cache);
 		max_win = cwnd_by_slope + nv_pad;
 
 		/* If cwnd > max_win, decrease cwnd

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtFx2IxDPJ5P2qvU0w5OcPVfBKL2ir2lUy1r9M4Bhdxh5Ie2in+ATueGHr5YKQSpCDN5WRF
ARC-Seal: i=1; a=rsa-sha256; t=1520641152; cv=none;
        d=google.com; s=arc-20160816;
        b=B7+CKaYLCiF/swfk9TSOflcr0dDoNh7Xe9570rjfIMsmJ3edhdtopR81gSjgPSfmyF
         37n++9vMBwevTXxUrVb5Qw65IPXe4QKb/Ienlp1PjLmPEg4O/w6uw59boEWUbZgiAabs
         ij/ey/S+fGxsmcuDYzJ9cRXxkC+dfHP3GnnAL9vakkhPldos3vc8qqIM8jBb/WaGO9j5
         Dl/EahfTeMldixlrtxzrpJUzg7CLMGILgHxrfIGIQOftCSTlHgHqBvdoEFuFUPgv3qwb
         r7urjQPAKQO1Qm8z3gIhWTpGAB7KALCumZve+C9TDAyR+gknJ1nGjsrTpQDa3KVbnOV3
         qNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i/tDe2/rjxJCgKXLePPQSVpC5PZY9p9ksT7cbBf3FWM=;
        b=MBd44h7iWdWnKMlSv3Z23sB9z95vEqkoB/jBQFmxoyZspKx8/GhllPZ0IuGSTfAuhd
         tfI4rhK+tEWLtv6NFd02Y3n32WywHORticTRejCSuulJIhPNLDikEN/K7K36/hsxLTA6
         ce6NwVgjkq/oNsLCZ2TfeLkU2sZ+zMEQ2yDk0ptMH/0kVJ/eDr3pW0jTuPYE3/XWnCDO
         ZQC6lbZ4DS2Ymag7wY0spUmPWQTwS2AENcNx7kpfLNI9CHrSZjZcK/uXxkSkdJ7vPekw
         YRhAbNhaml2vx9Oq9KpZYoOK7u40l/ffO8uSxqYcvrIFvt+1qC9GcTQ5KL8dfdEXzOTO
         RgYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Denis Du <dudenis2000@yahoo.ca>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 09/21] hdlc_ppp: carrier detect ok, dont turn off negotiation
Date: Fri,  9 Mar 2018 16:18:31 -0800
Message-Id: <20180310001801.580621737@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507817246578750?=
X-GMAIL-MSGID: =?utf-8?q?1594507817246578750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Du <dudenis2000@yahoo.ca>


[ Upstream commit b6c3bad1ba83af1062a7ff6986d9edc4f3d7fc8e ]

Sometimes when physical lines have a just good noise to make the protocol
handshaking fail, but the carrier detect still good. Then after remove of
the noise, nobody will trigger this protocol to be start again to cause
the link to never come back. The fix is when the carrier is still on, not
terminate the protocol handshaking.

Signed-off-by: Denis Du <dudenis2000@yahoo.ca>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/hdlc_ppp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -574,7 +574,10 @@ static void ppp_timer(unsigned long arg)
 			ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0,
 				     0, NULL);
 			proto->restart_counter--;
-		} else
+		} else if (netif_carrier_ok(proto->dev))
+			ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0,
+				     0, NULL);
+		else
 			ppp_cp_event(proto->dev, proto->pid, TO_BAD, 0, 0,
 				     0, NULL);
 		break;

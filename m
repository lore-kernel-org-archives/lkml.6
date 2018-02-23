Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsUVmzScAmrf4ZqYuTpnnULlJ3uYNTABeLvyqd32rVPifJEq1CkZsCNab+dn2OOY2Kw4gXz
ARC-Seal: i=1; a=rsa-sha256; t=1519410807; cv=none;
        d=google.com; s=arc-20160816;
        b=I79HijpR/4vFGlm3eMpi27ZtD+6BT1Tltkaje9JRoDBzho3wL7/UAMjEk+9R2rjEuT
         qrl9zhN/2sEL8UC+A2q3K3XN0uaOz7/DThbJIFwyi73VBwfs5XeVMPkr+0JZ+D78eATd
         TBcCZgR1q216FFEW5XQZzYocDaxgMo8AonQzK6/ywFeZOpnrkEU7NiYmhymYpuygSGTI
         gXPA/zLildODTrcfVozi1puhO3d3vD5dpCOAzFH2HqbEzFnW5/m6bknWP7RY0Vp1xIQE
         WXTTQ+QRyTtYIwBGjs3sGQSjUtnBsHGFLsxWuzLafarrEhssr6nLc/bfODSolxPAUTEh
         i5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tGrQIT9vxlw2IsGaTS38bfdPVEBw9aC6O9lqiPVVYQw=;
        b=ammvZMZukwOtnfkV+VM+u+6U4ZE5R9VoGjfoURyxLbBbqQdBd3Kuubs8R8MAlHHnZR
         UeqY3tlTpBvLuOWednplqhRPA7+3NnGJLmQ4/eK6jOqcuYm/5wifY/Np+e+dbQamivJP
         FWpeDCVUMxvLldwM4K5mxI2DTXUdtQnqSkXNBzrGi4lo9onHPT7+mnIaF9QmcJeKdbOz
         F9pZK9sz7vK2OOWqc6cEX+5NUc++5MsvR0mMuTUa5m0s1VAxghmZ2GEUI75EqQ67Nfpj
         1J90900TpwnbqgQw1nX4+/66WMXMnnt5II2YrpGDXeQYN4TUJXaEz/tdC1fFjQh/0I8W
         CebQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 020/193] net: avoid skb_warn_bad_offload on IS_ERR
Date: Fri, 23 Feb 2018 19:24:13 +0100
Message-Id: <20180223170329.250184813@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217549729214691?=
X-GMAIL-MSGID: =?utf-8?q?1593217707593068348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

commit 8d74e9f88d65af8bb2e095aff506aa6eac755ada upstream.

skb_warn_bad_offload warns when packets enter the GSO stack that
require skb_checksum_help or vice versa. Do not warn on arbitrary
bad packets. Packet sockets can craft many. Syzkaller was able to
demonstrate another one with eth_type games.

In particular, suppress the warning when segmentation returns an
error, which is for reasons other than checksum offload.

See also commit 36c92474498a ("net: WARN if skb_checksum_help() is
called on skb requiring segmentation") for context on this warning.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2598,7 +2598,7 @@ struct sk_buff *__skb_gso_segment(struct
 
 	segs = skb_mac_gso_segment(skb, features);
 
-	if (unlikely(skb_needs_check(skb, tx_path)))
+	if (unlikely(skb_needs_check(skb, tx_path) && !IS_ERR(segs)))
 		skb_warn_bad_offload(skb);
 
 	return segs;

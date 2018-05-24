Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZowOhB2NnJFeM9BkOdmUFCPp+2k0XC93/+xmNaWsDwHmsOML0NJuRRibq3ZkdIp3+DAGPZ5
ARC-Seal: i=1; a=rsa-sha256; t=1527155977; cv=none;
        d=google.com; s=arc-20160816;
        b=yjETHgRHuktZ4kWHv6Bi5uV9MScnsFtIr18q/sTJJ+EMOldMXE7kWkK9moq19oUcvR
         nLsEEEZRTl3xRBs6HE28PXBJV84iIya+YdDirGrMhsef2sFbTvvTF1pbLI0n1igV3Ms9
         9HMnp8SB29pYe8flQESp79CMr5AYDTqV39Jt7rjuaqgO/t/xyjObvEeV1vNF8afraCc2
         d+Zq7qkgOS/09sWRGb37D8GuGVTZ3C14zWsEuAcyppWDdtjYWgX19tDjBmAR5hVe2TGy
         5YhFeTCkPlxHLODpEQEPkGKpLHSNLzxg2/viZ/C1lg8cNuAnG5Nkt41rgcbObZ2Hspuf
         I3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=c1eE9mBBbs5I+cHYv1Udynv+hsbbvLZkbGlXFsL+aEk=;
        b=aGHRS/gvAEDXee/CVhyWwILUUaxcAdcG886+mdTKmhxS7+16NRgC42WEQZlZ9yJKLD
         8j+/Ok4poFMnVvaDKnxUIO979D0suhu2to99isaEokL/SOan00sCKbzplHEGhfvbBsuI
         G9wfc89e92t1Oxm3o/fEByjsY9qyFa1eXFPzQG+vKWO8Dohne5kiQ418HIx6EAMSQaGC
         lHOjLQQDdD1hVgsEsbfHNYaozj+CmhP4FYOxiiWyRutS2YUKdU3vUCeV8Xt9B5ir5qRD
         wJZesIKqvqFqJ6/H3f3+M7enL9ENjdveOyY7/gbroN7jC14QcSM8UTwyIliJ1Q4knP+F
         5ygw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JZZ/OLnv;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JZZ/OLnv;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 002/161] net: Fix a bug in removing queues from XPS map
Date: Thu, 24 May 2018 11:37:07 +0200
Message-Id: <20180524093018.638608424@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338598395812562?=
X-GMAIL-MSGID: =?utf-8?q?1601339106300820830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amritha Nambiar <amritha.nambiar@intel.com>

[ Upstream commit 6358d49ac23995fdfe157cc8747ab0f274d3954b ]

While removing queues from the XPS map, the individual CPU ID
alone was used to index the CPUs map, this should be changed to also
factor in the traffic class mapping for the CPU-to-queue lookup.

Fixes: 184c449f91fe ("net: Add support for XPS with QoS via traffic classes")
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2097,7 +2097,7 @@ static bool remove_xps_queue_cpu(struct
 		int i, j;
 
 		for (i = count, j = offset; i--; j++) {
-			if (!remove_xps_queue(dev_maps, cpu, j))
+			if (!remove_xps_queue(dev_maps, tci, j))
 				break;
 		}
 

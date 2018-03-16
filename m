Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs2AhWwvN5Z0WZn6IxiwflrSpjn8XUobWsInegHLXRLtqKcR202QTPj45m8/alux9C93WBh
ARC-Seal: i=1; a=rsa-sha256; t=1521214231; cv=none;
        d=google.com; s=arc-20160816;
        b=bu6lpj5mqjXaSRiSrUfyQruTx4Aj4fFHNLPPtFFtVJnGD7bvITY18x+VkrppEjzJPV
         NZlwB+hp+5Irft8vQM7RK8oBrxfSouZLp+QG2YaqEZ2CiDPGbjDtme4SDgKOlHo5SGRO
         wQ3fCchT5jJCSXs37EuZva/K/VrtOzetQwyOnIaKSCNUVrRAmAniXfLjs3oOdmwTTXan
         haZ1N+vlaziZFHB8rxo0nJrJS2hjrS8lmfnOUFSXXFn6PWcLyjwcSTSl+gZQhBy0lYAC
         6oyWPse7AwnvzG3bBnzBAyI+zmpir0LOXlBvcHxcY838sonSz9bFgxxIah84//tbVbb+
         hQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D49be6oPyNQRc4K3zKyAgm9DqBN0PyH1i6BDdVKFoU0=;
        b=Qr3N+6FpzaKH4fe+kGnfI6WH+9zqIaUiwEMuj5ZzzQxjVHxDRsCWnSpt/mzXZtzwXo
         AZlha4d2sM8IqrdhrRd79RdokiXABxOIltOUXYEAlSe1KnZJxtlAFhgLa9N6sAWatJV9
         mrW1y35ChJv5mSXunE8TipxoS/G2NbcraCrQOI9z97KAmuPWDsXylcjhz99QxAJ2BX4J
         qw/dx/qEipCIG6AowpOZi3pBXi/ubE5q/oT2z0VKr99t0tr9R+3so1D2TN6x4ZRnAYst
         tudY3bRODUEj4+0zXAu7FPxqgIsgfH+zmavtbo7dEfZd5G7Z6GWc8LPePdzTBj2mIqVR
         EjPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH 4.9 22/86] virtio_ring: fix num_free handling in error case
Date: Fri, 16 Mar 2018 16:22:45 +0100
Message-Id: <20180316152318.866123947@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108733886715076?=
X-GMAIL-MSGID: =?utf-8?q?1595108733886715076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.bie@intel.com>

commit e82df670235138575b37ff0ec24412a471efd97f upstream.

The vq->vq.num_free hasn't been changed when error happens,
so it shouldn't be changed when handling the error.

Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_ring.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -423,8 +423,6 @@ unmap_release:
 		i = vq->vring.desc[i].next;
 	}
 
-	vq->vq.num_free += total_sg;
-
 	if (indirect)
 		kfree(desc);
 

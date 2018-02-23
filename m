Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvPsErSA7sgB2s4VvPxSkfxGLotoXI1J7g66rFvyfcuyOFRhStkHl+NJjJfTvPRTP/fKNw1
ARC-Seal: i=1; a=rsa-sha256; t=1519412354; cv=none;
        d=google.com; s=arc-20160816;
        b=wlnD3ohfz9azjw+KqNEtuOUchJrs0W4n9lbrrZKcORgzY+W/zuPXukKdKaNNGPFeBk
         aGD/HBspmJQ+vzbg2GFy4f7FGCoxHzbuCMgwd65rAs/F/VgWqpDi/wgyAhEiF8QQDZWE
         nRg/wSip54zCytiLIM160x/woriD9QX/ZVsxEyli/4YbrkXFIep6XhNzhcUaEYq9y7Q0
         Lr1Djctu2iuO6JO+vDkgibFsfmjZN+O4ZJ54HhF3T1fofW/BiWWRb21TK6ElZfC8Yd5W
         Ozt4sXQftmdXLjbNb3O7pH6cCRFS05hMVE83g7F2Ej+gns2B2C8dkzTsgvNUWyZl2RsN
         t0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lDaRuFkwj2F6fnlqI8GKynvYbKS48Xsf9nLYghshU+0=;
        b=eLGZqKkc8LEhdDNKRYg9AHo+77C8IIsFRmduoWm0FI4sAhJZ9eqPeDzdDHaeM8yqfw
         7MsH6ZNT8vVqyd3KDTwfL17hyc7SgeR5hFoK8fOvQqStPiKkQrfV/Qj97at1UUnlNcxa
         KdAJy09LXCfKuc6Z78w9Sbvi1wU4hn4Z/WuAprCZInf2BoXbkC1tm/YqRmted2cX2/0F
         65M+KGI5SNkOky/apAbvD1k/lHy6biukyH1/mMMWPcRIZUB5DhjGQNkOhUohFkfRHSzU
         afEC169uWCOW1W03jqdPBHgDMkgKn5OalC1WoJuFuKMu42/7yq1yI50WfDorTe8v+4xH
         fX6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.15 31/45] staging: android: ashmem: Fix a race condition in pin ioctls
Date: Fri, 23 Feb 2018 19:29:10 +0100
Message-Id: <20180223170720.230960956@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217726489557285?=
X-GMAIL-MSGID: =?utf-8?q?1593219328706996124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

commit ce8a3a9e76d0193e2e8d74a06d275b3c324ca652 upstream.

ashmem_pin_unpin() reads asma->file and asma->size before taking the
ashmem_mutex, so it can race with other operations that modify them.

Build-tested only.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ashmem.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -710,30 +710,32 @@ static int ashmem_pin_unpin(struct ashme
 	size_t pgstart, pgend;
 	int ret = -EINVAL;
 
+	mutex_lock(&ashmem_mutex);
+
 	if (unlikely(!asma->file))
-		return -EINVAL;
+		goto out_unlock;
 
-	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
-		return -EFAULT;
+	if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
 
 	/* per custom, you can pass zero for len to mean "everything onward" */
 	if (!pin.len)
 		pin.len = PAGE_ALIGN(asma->size) - pin.offset;
 
 	if (unlikely((pin.offset | pin.len) & ~PAGE_MASK))
-		return -EINVAL;
+		goto out_unlock;
 
 	if (unlikely(((__u32)-1) - pin.offset < pin.len))
-		return -EINVAL;
+		goto out_unlock;
 
 	if (unlikely(PAGE_ALIGN(asma->size) < pin.offset + pin.len))
-		return -EINVAL;
+		goto out_unlock;
 
 	pgstart = pin.offset / PAGE_SIZE;
 	pgend = pgstart + (pin.len / PAGE_SIZE) - 1;
 
-	mutex_lock(&ashmem_mutex);
-
 	switch (cmd) {
 	case ASHMEM_PIN:
 		ret = ashmem_pin(asma, pgstart, pgend);
@@ -746,6 +748,7 @@ static int ashmem_pin_unpin(struct ashme
 		break;
 	}
 
+out_unlock:
 	mutex_unlock(&ashmem_mutex);
 
 	return ret;

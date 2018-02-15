Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226woX5wemGl1QJR8V0pO6BudgV8RgOgwoBASEscPghvFpNIZ0Ea4LvTg657EMri6oqh5s3/
ARC-Seal: i=1; a=rsa-sha256; t=1518709021; cv=none;
        d=google.com; s=arc-20160816;
        b=Y6u+786J6IdpZYvjNnrUhgC9K2Y1qG4h8EevMADXK0UCtnMn3uIxo39UsKz6XKkLqu
         A8pS2OKUIvou4MXc88ixfu8Ws3LvFfCC11rlTVIcQ9dQ078/l/CyJmB+cOFONkPeCNUG
         U2VyocOxtZDB4VqFAEgIx80sbmd1uZpmpnD3tId5rlP5+ekkvfD3y1I/oE23eVOb6Dwy
         EVzvi6GEvbt0wykxqpw21bsG2t89Lra+UBosNMQaHokwbvFJOyiDCbczmNW/56lqb9Ed
         ZkzKRy8VopVPZTOZRRho7ZKPuJm45ig2NIUt3XjFBkYr/Z4t7bH77ueZCJU4+dbG5oN1
         mUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sJrTUn+E3IhVGnWgvIzT/tJ3HVeNCfwWn9yb2xtC4t0=;
        b=jl8TJOie0Ghjv6qPJIvXtCEvJHu8z4UOBVQX/xcRZi5+CQWQcyeqON2UZwDR37Lmsn
         503JK80ywLPnrbdQg9WI1MpxuyLs1VAOwGFKkoDiI1tDySceLqbANoa0JVJ5g+kV+Aoh
         +iMgwND4oocxDAz30ofeMX5do2Y7l2dlxmhm1gZ55+Xf9HuD9YPm4bIxIuEok8aXpu1b
         IcwoZE61mYTf4NmYFj9HO9NDtR2D5fLIlWJEtlVOX/HQWJM8K6O8BUwJeH2Ox+qfin2d
         KXk5tpS3GQ6kbaVYLxa7HqQ1jIk4L+ad0mTeYuHZwXsat8BT8nEHE7cdx/yEhXhbQ6ZA
         rkJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 129/195] media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
Date: Thu, 15 Feb 2018 16:17:00 +0100
Message-Id: <20180215151712.200067166@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481022948715937?=
X-GMAIL-MSGID: =?utf-8?q?1592481831045201119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 169f24ca68bf0f247d111aef07af00dd3a02ae88 upstream.

There is nothing wrong with using an unknown buffer type. So
stop spamming the kernel log whenever this happens. The kernel
will just return -EINVAL to signal this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -179,8 +179,6 @@ static int __get_v4l2_format32(struct v4
 		return copy_from_user(&kp->fmt.meta, &up->fmt.meta,
 				      sizeof(kp->fmt.meta)) ? -EFAULT : 0;
 	default:
-		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-			kp->type);
 		return -EINVAL;
 	}
 }
@@ -233,8 +231,6 @@ static int __put_v4l2_format32(struct v4
 		return copy_to_user(&up->fmt.meta, &kp->fmt.meta,
 				    sizeof(kp->fmt.meta)) ? -EFAULT : 0;
 	default:
-		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-			kp->type);
 		return -EINVAL;
 	}
 }

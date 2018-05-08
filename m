Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AB8JxZonbBLsmBfVATlb3OOVWjK49x858Pi6GsKlEIeK1fZD81SrZzHwZy54zRrH0PonAayMOlc8
ARC-Seal: i=1; a=rsa-sha256; t=1525781811; cv=none;
        d=google.com; s=arc-20160816;
        b=K7jL35FfTGHZHrGvyhbV9QECgsHA1lnxB58mdAKio606bPN9tUzKzgPE0Dc1gup73N
         w9JfdddWb316wjENwASLq/8UpbVWMD0Ybu+FQ1Xi0hw2YMYFIsyRSSt/fTxUMRauKU3F
         Pv4muSrbvI5Rn0oklqoJ/XW44RicaytjGTrVX/6kAlVfAc76KcalUlhneshEhmAWAtAp
         bRfUN0KSTyGrp8TUYaH5Wo4SItV5AHh+iWUxCLBxHqkGLC1rBoSqHzu2AQcWLuHKTeYz
         k3FV+h/sGW/xZVyS071bcz5lk2tgwgJ5G5i5eOfMPA30iOBo9grxFRxMtP2Uik7xhPWM
         uCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=a9CBzZweJIv9/MnoV/TC7bIvSjBMTPcFjvo4yjAO3LM=;
        b=Q4jdicYG0lIzAIXxjzN4zXXPIZrI3ws4VJ4vgEfPbXLmFTqdnh9l7UwyVdE4JYueOW
         YkdH/M9cVVEQl1BfgeotgHemONrsObMQAQ615VaOf62YWjq20ODf/2n40lclHHQBrILX
         rmxvfl8wVRgARNa2EYmHUWKb0qDPDS06/UiN96+3hRi/1mPnkTp6GUcFiN2CQ6l8G8t/
         T0HcnYbv1cVik/K5e9sEF8JuVlFkTdlLrLseGieSrvUMXTXXysozVfbQqRcaJjHM/iYT
         p8LVWEU7gYTQrcTnwLExgBhbdD/LiVattH6VXDIQsGUCN0AxXAeC6wbVwNc3h81ZEldx
         E8vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tU38J55m;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tU38J55m;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Tue, 8 May 2018 15:16:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wenwen Wang <wang6495@umn.edu>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "open list:STAGING - ATOMISP DRIVER" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] media: staging: atomisp: fix a potential missing-check
 bug
Message-ID: <20180508121635.mdw4jikv66iyprie@mwanda>
References: <1525300731-27324-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525300731-27324-1-git-send-email-wang6495@umn.edu>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=867
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080118
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599393747900387659?=
X-GMAIL-MSGID: =?utf-8?q?1599898188271743385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 05:38:49PM -0500, Wenwen Wang wrote:
> At the end of atomisp_subdev_set_selection(), the function
> atomisp_subdev_get_rect() is invoked to get the pointer to v4l2_rect. Since
> this function may return a NULL pointer, it is firstly invoked to check
> the returned pointer. If the returned pointer is not NULL, then the
> function is invoked again to obtain the pointer and the memory content
> at the location of the returned pointer is copied to the memory location of
> r. In most cases, the pointers returned by the two invocations are same.
> However, given that the pointer returned by the function
> atomisp_subdev_get_rect() is not a constant, it is possible that the two
> invocations return two different pointers. For example, another thread may
> race to modify the related pointers during the two invocations.

You're assuming a very serious race condition exists.


> In that
> case, even if the first returned pointer is not null, the second returned
> pointer might be null, which will cause issues such as null pointer
> dereference.

And then complaining that if a really serious bug exists then this very
minor bug would exist too...  If there were really a race condition like
that then we'd want to fix it instead.  In other words, this is not a
real life bug fix.

But it would be fine as a readability or static checker fix so that's
fine.

regards,
dan carpenter

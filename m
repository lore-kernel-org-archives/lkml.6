Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AIpwx4+APROkRpS0Oe0jqlehNPlHa7XsNsiBrYtk8i95JEFtDU8iXGQ/7hIUXeALiyEHgWQpINKE
ARC-Seal: i=1; a=rsa-sha256; t=1522763540; cv=none;
        d=google.com; s=arc-20160816;
        b=r1O8eq/cEi94NVvRwoCSXnk7/fqdjgO8tW9y1Ko9jTCrrJSnIrku081cAr394trh3H
         xsQuDKpc7WIwBgPtAN/MlFtdIZ3yHqvmSz7NLe1ytqnuhk1VqgpmSBlAP6yL9R/CowNO
         YRSODwIrSGrln+TcMK7IcTWTtDA0RI+mp3cRuI4We8gKrkNVqz38NLTAzff2wpt3mK7e
         pKIrL6dFn8lV6w1S9d13c2Z/HFjP6YR82rW+ESPWtnYIwIZGIJcVgbppc4WJKWiaT8R8
         c68pq5NnZ0hmXrtRWQ03Yd3R2feLQWHzDTSgnF9lKkrpOo9bCKWcOGZawGMUllrjUndN
         3A0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=GoE87s8AIePtFEamd4pWghFGhYnmiYNN0tkhk+hAuOU=;
        b=MaWdl7fvHr8HjsPOr64yi4/ZZS3W+iitEQMJsCDjumLtbKVaVqBwLDC8lMk92GwLDj
         QoQkO/gzZ1rs1T6eTk3vReIFgJYVDWakTzM9Ye5YWSQm0BVhQk1pahnq5NM0DS/aEi9K
         6O9hxiPG05lSdn4pY8R+NE4eFT2pGi9CXU6a1onEg0FPfeaTtsEZTS3QsrZZRdFBgQ6K
         uGbzoRmN1sWbdsKK1He8qkLpm2DcQmYz2wRgAoQFHKyC83yGsCOR3g0s4YnU7TZ2kY1t
         QCvvHsHBCYwc9e2tUCjytIB0WlKXvwP2n4lJtb/RD0xC+UJtJ3mXbkcx678EyeETftFt
         zGRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=CRAJm+fi;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=CRAJm+fi;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Tue, 3 Apr 2018 16:52:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Xidong Wang <wangxidong_97@163.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Xidong Wang <2711406067@qq.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] taging: fbtft: fix memory leak
Message-ID: <20180403135202.3lj4dwafogo5bwrf@mwanda>
References: <1522761268-7176-1-git-send-email-wangxidong_97@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522761268-7176-1-git-send-email-wangxidong_97@163.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=435
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030138
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596731155733578693?=
X-GMAIL-MSGID: =?utf-8?q?1596733302290492441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is a typo in the subject.  It should be "Staging" instead of
"taging:".

On Tue, Apr 03, 2018 at 09:14:28PM +0800, Xidong Wang wrote:
> From: Xidong Wang <2711406067@qq.com>
> 
> In function fbtft_framebuffer_alloc(), the memory allocated by
> framebuffer_alloc() is not released on the error path that txbuflen > 0
> and txbuf, which holds the return value of devm_kzalloc(), is NULL.
> This will result in a memory leak bug.


The txbuf chunk seems to have been dropped.  You're right that it needs
to be fixed as well.

        if (txbuflen > 0) {
                txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
                if (!txbuf)
-                        goto alloc_fail;
+			 goto err_info;

regards,
dan carpenter

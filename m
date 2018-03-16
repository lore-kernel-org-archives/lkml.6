Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AG47ELucq548ueHPRbmI3iFvRBmORJvvvqmTJUBUG56FjlSxlOrgUtmW4VRdnMVjHEi0GBeEwlL1
ARC-Seal: i=1; a=rsa-sha256; t=1521187395; cv=none;
        d=google.com; s=arc-20160816;
        b=oVEdbpRZrmSmTnZ7fYGYlwcnuqKuaOtfYCDOVTewLHbZR4VWv0xyQ8q8y4MOVuqMqH
         sQfEQ1HfSQDllnF6WXiccoKc7rYwgi8aIbZem/yr1VeTn2g7Q5CNogs63WE0sk/3MNqF
         xIKxuicM3wAd1FyF96VRDrvkuZPj+pLF4+UmxAuxriOcS9IEWEHg39UtEXFmVBPyB4RU
         ZLoEg85xrENTJnZHs1CvDvsCZIuQKOwbV5pl07hCcGncibAr7NOOQYqHvJFcN2ifS8A6
         wrNdyc9jVVCqosp5flT6AwRgEGCfZ1GiJOwK7PcrmG1yJy6eJUJ3hIhpS/2BNdKAwvJc
         O9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=QOJpeIJZm4+AhTW7DScH2Tdi60FA9YJgu9o3F4/NEw8=;
        b=yWQTWZ0frs9yBnyEyY/GHSziPfm53ho0AYPqjS8+oS3SFiH8y3USZpUE8P32IBDMiT
         0ESjtBSxo1mjbLpdm2lsrRujPClD11fda0Sd0sHPIcWmszrgDzU0TdizpEPUYkblsZCg
         HwjMNobDGFE7Msrnu5I1LTbRieMIzKxm4YbNGXuf5T6cXATyCLzskuXWZoKh3o3adF0e
         LbVfOpLp9lDGDPtmul8hyIn3omFyyvDbz+i8aDk5/oyvPOG4wk3SclJqP+oe7q8sEYh/
         01CCUK8LJdNlDJ91OP1Ui5XgOgznKi1orHoKAWbyr9hQ4KCvXUr6rsigxjTZHWxg19vR
         JeQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PnE8ZDpc;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PnE8ZDpc;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 16 Mar 2018 11:02:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 7/7] staging:iio:ade7854: Add proper error handling
 condition
Message-ID: <20180316080257.dlglfjespmltwo3u@mwanda>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <20180315121115.iwkx2dfikgpjeeec@mwanda>
 <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=400
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160005
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594937723243519644?=
X-GMAIL-MSGID: =?utf-8?q?1595080594601801523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

You're right that there is a bug but this is not the right fix.

The ade7854_i2c_write_reg_32() function returns 6 on success which makes
no sense.  It should be zero or negative error codes.  All the write_reg
functions in drivers/staging/iio/meter/ade7854-i2c.c have the same bug.

Please, fix that instead and leave ade7854_initial_setup() alone.

regards,
dan carpenter

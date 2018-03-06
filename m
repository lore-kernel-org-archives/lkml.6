Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AG47ELtqOPyRfUrL9xA9gJXygoO2FxjKx/TCEgmtqDXjqd8zlsUQedKweooiuauj2liqfWl783cG
ARC-Seal: i=1; a=rsa-sha256; t=1520329664; cv=none;
        d=google.com; s=arc-20160816;
        b=AzU+oaf7XlYt4vJIo7nr85n2sTdS4pvkLzy8w3jNzUiu55x957T8xuxEMFn12ymxQn
         MJVh0dEMjll2g8oTfoT7JdlfF90Yzn1HpiWntFpv5NxNzEbwQSI4MT2mhuGa61+9JEw/
         dmTW8ZAnHry6yJ+YDXsiuPXc8xhyw8xZvvoRsr/mKZs6PurE6y7lrWdkb6hsw+Gl51du
         ZEm+FyYnpqpj67lrtkDNJL8F9SYSy+VzIksAQg19rLMrGvKJZxHynykXHyKKRV4FFIZX
         NAFteAxzIkmK4c/eXQHaExF/w0Z1Avzm7UXlTJwlDn+Zoehuv7arzpCQ6RCAblpSjTgf
         4LnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Tzk8OZQbcVUmFcnfytazyLv7HugpMU9QBcwBwrCoSbo=;
        b=RS4U6fU6heD/AsVYrRb42SLSDvKaxcMmWWEeaXfSzc0/zXaDm3B9DTZ7Fu3rOjxvBW
         FNiQTkklgy8cm7jZCY7stWT6wknG2kdKorOX0rMVrXnXxhKEqRLfzEbKPv3mKTkpWKaE
         +qrZiPj+tpp1UbqqOoxsGakgTwI28WD/L803bXZ4R0201A5aVlBizSOIU0TC80sBGz3F
         KkJ/8nKDs0kw3Dtdc6T5ObfWEYmCWft06I2PSgmeFYNEb4PYYed5dqzalLRai7sL4CGQ
         W18weer2SlRwk/NcQ257DfMtUHVE9xbrMf8+w+WGrDK0X6jD+xGNFTvKTxft+QVrUF9C
         lxww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=SYGXal/f;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=SYGXal/f;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Tue, 6 Mar 2018 12:47:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        christian.gromm@microchip.com, chris@engineersdelight.de,
        linux-kernel@vger.kernel.org, Michael.Fabry@microchip.com
Subject: Re: [PATCH 2/4] staging: most: Replace calls to BUG_ON() with
 WARN_ONCE() and return.
Message-ID: <20180306094728.xbhamhpwdphv6kju@mwanda>
References: <20180224075835.11618-1-quytelda@tamalin.org>
 <20180224075835.11618-2-quytelda@tamalin.org>
 <20180301162130.GB15087@kroah.com>
 <CAFLvi20e+D4984vypj7nVECFxh_AKVwGWTqCqfyFYJ9AV=Rvdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLvi20e+D4984vypj7nVECFxh_AKVwGWTqCqfyFYJ9AV=Rvdg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=433
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060113
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593268397961397380?=
X-GMAIL-MSGID: =?utf-8?q?1594181198496608752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 01:23:18AM -0800, Quytelda Kahja wrote:
> > Are you sure this will work?
> Well, my goal was just to replace the code that could crash the kernel
> and let somebody with a better understanding of this particular driver
> write the recovery code, if necessary.  It seemed from context that
> the BUG_ON() calls were being used like assert() though, so I assumed
> there wasn't really much recovery to be made from that problem.  If
> you feel this doesn't improve the behavior of the driver, just drop
> the patch.
> 

mbo is always non-NULL just from a quick glance.  I didn't look hard
enough to verify that mbo->context was OK.

It's generally best to just check the callers and delete these.

Say you have a BUG_ON() then that prevents memory corruption (not an
issue here) but it makes debugging hard.  But if you just have a NULL
dereference it probably kills the driver but you get an Oops which you
can debug.  So a NULL dereference is normally better than a BUG_ON().

regards,
dan carpenter

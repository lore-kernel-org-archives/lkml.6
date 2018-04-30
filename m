Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AB8JxZrd7fmG04XESdqqQP8PjrFOYGklfnONz+7b57JiTmVR+/kakUdcajIQX+E5hDV2ETH1P3qX
ARC-Seal: i=1; a=rsa-sha256; t=1525086959; cv=none;
        d=google.com; s=arc-20160816;
        b=0XhyrVWS++RdyZ+5idP4zVPYHxnB9j0DJnY3a9cd7jXyxMrJ43IPNyVG4ORxcpXfu4
         7J9mugVzSG9N7NnffBz3BI8ETH/PIQMTyvFtM+pFwsbnAoGuDlH59FmgQm3NURDNBFe7
         cJbnjVkjV8E9kmKa9c3wSQYpKmvtMPGKkUIbh/LdDL8w5fEjPZtbczL1XVGKcPkmGoN4
         WIzBf/KSnMolYuZQ8XlYTDIIO9fJ/BQ9rkOTrDBj9G0tF4EFNwsRxMtjZJ/WcYN2EYwd
         zgzD+CfHNkMNpX/mSyZUd6BWRECVpFCLervCg8nfZdmXuLeUUWl33DhEwyGCqCNo568y
         n4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=9CTFmUZ0ZlBaa7eU+0iXHnYQJgiID6jWHHFTn8WrxI0=;
        b=hd5U9rmowGO4tyueuplVoFcvpG02ezkhUv5P5xQRQLf6LmoH1q53qRpLsZRXkyqy3V
         9sJBMjvTkHyul6Qtp9n4asfTukKjXtr6Eu/QR6s93+zyoq+iGV/bcgguc3FktqQaSEE7
         ic2F0cvBqA89adaG+yXtnnhqlOym4F6UoINXoziMywswkScSTA6gc/mxKJGmQWNr/pON
         8lZFpLFLsuQ82bhOLPRIcYay+ozh7apOgAUpLeoPNzokUtM5C7gHonG4MiYzHmJFWcd1
         8tSfKd5A9pR80IiLpJPgltRKveKYMW0IpjQH19HpBeVArhx6FTMN0ga8DeWzVLWL8Um0
         H9aA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rfa0VTaL;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rfa0VTaL;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Mon, 30 Apr 2018 14:15:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Aastha Gupta <aastha.gupta4104@gmail.com>,
        "Dilger, Andreas" <andreas.dilger@intel.com>,
        Jeff Layton <jlayton@redhat.com>,
        "Drokin, Oleg" <oleg.drokin@intel.com>, "kjlu@umn.edu" <kjlu@umn.edu>,
        NeilBrown <neilb@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Evans <bevans@cray.com>,
        "lustre-devel@lists.lustre.org" <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH] staging: luster: llite: fix a potential missing-check
 bug when copying lumv
Message-ID: <20180430111535.gnycdzkok7cgi3ue@mwanda>
References: <1524872704-13391-1-git-send-email-wang6495@umn.edu>
 <8E6ADED8-592E-4794-8CAB-913A325B1971@intel.com>
 <20180429132058.GB5972@kroah.com>
 <CAAa=b7dPWAsqfQOWzvecHqAHYuhA63_+ya6nOMdPQ7ZaL6JB9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa=b7dPWAsqfQOWzvecHqAHYuhA63_+ya6nOMdPQ7ZaL6JB9w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8878 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=583
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300110
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598944943578176100?=
X-GMAIL-MSGID: =?utf-8?q?1599169583874983459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 03:58:55PM -0500, Wenwen Wang wrote:
> It is worth fixing this bug, since it offers an opportunity for adversaries
> to provide inconsistent user data. In addition to the unwanted version
> LOV_USER_MAGIC_V1, a malicious user can also use the version
> LMV_USER_MAGIC, which is also unexpected but allowed in the function
> ll_dir_setstripe(). These inconsistent data can cause potential logical
> errors in the following execution. Hence it is necessary to re-verify the
> data copied from userspace.
> 

This change doesn't really prevent any bugs in current kernels since
LMV_USER_MAGIC is the same thing as LOV_USER_MAGIC_V1 and the users are
allowed to use LOV_USER_MAGIC_V1 if they want.

But we should probably verify it just to make the code easier to read
and because there are static analysis tools which will warn about read
verify re-read type bugs.

regards,
dan carpenter

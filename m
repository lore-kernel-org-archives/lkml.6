Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AB8JxZqwES81zw6pFK1Pwn2izup+fPiWbW1wPnCSQa3luJ5F/ilgzqszGH8P7myQpKnfdpG8V11d
ARC-Seal: i=1; a=rsa-sha256; t=1526385903; cv=none;
        d=google.com; s=arc-20160816;
        b=mltTwpdvjXaX7w5e7SC8CyqgQdJHpBtKuj7SXtjU9EBYHyXuO8RftwAcSfDRmnG/qj
         rtomYb0WXSfIYqU2L8RYerTdTRkrQ0EwgRhyNVIAVrelqPPk89g8oxnHA3sfcvd013/j
         buhdOArrOPfXusKUBbo90uyFL4x6I3NVukTT8/dF0D/a87abAw2ZhVsXbxAALY6QJGJy
         X9Je+bu+4zQoy2kxsCF5Bhiu13nrRcdGDcyItYrDq9fXRLlN9K7BperIn9Gj5x5PDlxE
         lvKkOAv2jTMx+c2wHmGeGjxdsZE6f3njwEhfo27GQ72H1M1aZQCRMGyUsJ3e/bnGh+Bm
         vVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=yqXLlq8rFwoP1EHHV6P4ru8LjHb8sDyrhym2YN8LFHg=;
        b=FBZe40CO6bp4ejOfVTY6VGDI0WarHTEksfHDiQ6WCynZFTsJiJrve/w60egYHGqvOe
         dXgPyOWqkRKMTBSAP2uSbs3wrRwJMJYnDDd4Wpr/iv3Rnafn2iQG3nRdCN8hv0S49uDU
         upGxBipnIOFIccckBCi6roWDWGHQ296g9wKs/45VRWDNXph5M/cnAw3SG8kWBn4m0F24
         IYGYy8OkeEj24EgKg5M3d90wpJWFD5xrEKfVsU0kXnndmxEfmZTSVTtvC2qjxxUOrnM9
         15/q0pq6Ocn95FbHzbJY0lu+B8ZD843YYsehSKiqUG1SIoIlXTrAJ4NPCJF3TxQ/5ArH
         w/SA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LIryMMRG;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LIryMMRG;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Tue, 15 May 2018 15:04:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Eric Anholt <eric@anholt.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] staging: bcm2835-camera: Replace open-coded idr with a
 struct idr.
Message-ID: <20180515120446.74vrnucehduhi554@mwanda>
References: <20180510233107.1684-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510233107.1684-1-eric@anholt.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=571
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150125
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600121806670452700?=
X-GMAIL-MSGID: =?utf-8?q?1600531624829271504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 04:31:07PM -0700, Eric Anholt wrote:
> @@ -258,32 +181,40 @@ get_msg_context(struct vchiq_mmal_instance *instance)
>  	if (!msg_context)
>  		return ERR_PTR(-ENOMEM);
>  
> -	msg_context->instance = instance;
> -	msg_context->handle =
> -		mmal_context_map_create_handle(&instance->context_map,
> -					       msg_context,
> -					       GFP_KERNEL);
> +	/* Create an ID that will be passed along with our message so
> +	 * that when we service the VCHI reply, we can look up what
> +	 * message is being replied to.
> +	 */
> +	spin_lock(&instance->context_map_lock);
> +	handle = idr_alloc(&instance->context_map, msg_context,
> +			   0, 0, GFP_KERNEL);
> +	spin_unlock(&instance->context_map_lock);
>  
> -	if (!msg_context->handle) {
> +	if (msg_context->handle < 0) {

This should probably be testing:

	if (handle < 0) {

>  		kfree(msg_context);
> -		return ERR_PTR(-ENOMEM);
> +		return ERR_PTR(handle);
>  	}
>  
> +	msg_context->instance = instance;
> +	msg_context->handle = handle;
> +
>  	return msg_context;
>  }
>  

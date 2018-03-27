Return-Path: <sergey.senozhatsky.work@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522138221; cv=none;
        d=google.com; s=arc-20160816;
        b=E583czH6/cFpRq2sLStv1t4pbzX9kBhYq8VDPWMlrOp7SlOXajsZ5l+qTNDZBs2MX2
         qG6+vQL42YDJ97gjiosJqmq9BAYhZbGkLNGrxqKLQ36E8s/bgec67jEeAY9oHUoMGFpe
         OkrNaiVMknLeky29AVXGaubdmbY7o9A1L4nupn5nm/0iotcMI/6cwSyU8usOGhVjK6o7
         fePMauUXFWld+SB9skrI56+shqoEUMkFQJNmlNmdmiI+53mynlg/Cfh7Wr4Ie5IfkHgV
         ZbynUBmCBfFLqYQhTiKgdC4927h8ucm9Fg02Qu5zFBvJbdOP52TQVfzjIBKLh+/lMQfe
         Anbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=dzyx2fT14XD0bmhPuQwg79cO9MeaU1NslJSgDiwfzJA=;
        b=Xq91P3nYZrGTGr1EmDKkvfximxZOjGHmznNs/i4SMftJXnDuWlNABWLjom4/zEefej
         a2I27ySSl1QL3tgm+fflRHKje1dkBGyGjg9t8lJ7xrhc01EHx8UgQjrF0Z3M4KTlpesd
         3/528dWoDKA7mUV6bZp04A2MsZBVTP9rJ3lFoNj4JjgrRMm1CXdO9UMO2AKMwc3XSKoT
         E45/cMT86cgh9grbQ94110UI4eYyd5Xa2VKoqqiirwlPpA90vNhXlqM00QYk40cFEYsC
         CDJ9k0j2AIOsvd/rrCG3Ax0S3vguomVSbxvw1oMCLBS/3+eAJPunOUWL8/PrtNzPWg9b
         C41A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=I5K0ilVM;
       spf=pass (google.com: domain of sergey.senozhatsky.work@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sergey.senozhatsky.work@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=I5K0ilVM;
       spf=pass (google.com: domain of sergey.senozhatsky.work@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sergey.senozhatsky.work@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuTlpSq+DbXMcCwj8J2PGfdWFgu+DUCNuyF/iQnur+1/ufvCSOdSbjyNh01TB3B9yplkgpR1Q==
Date: Tue, 27 Mar 2018 17:10:15 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 4/4] zram: introduce zram memory tracking
Message-ID: <20180327081015.GA3307@jagdpanzerIV>
References: <20180327065033.181819-1-minchan@kernel.org>
 <20180327065033.181819-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327065033.181819-5-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596072611048521150?=
X-GMAIL-MSGID: =?utf-8?q?1596077607085322664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (03/27/18 15:50), Minchan Kim wrote:
[..]
>
> +	char flags[__NR_ZRAM_PAGEFLAGS - ZRAM_FLAG_SHIFT];
>

Technically, you don't need this buffer...

> +		snprintf(flags, sizeof(flags), "%c%c%c",
> +			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
> +			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
> +			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.');
> +
> +		last_access = get_seconds() - zram->table[index].ac_time;
> +		copied = snprintf(kbuf + written, count, "%12lu %6s %12lu\n",
> +						index, flags, last_access);

... if you'll do flags decoding in place. But if you prefer it this way
then OK.

	-ss

Return-Path: <stephen@networkplumber.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518543284; cv=none;
        d=google.com; s=arc-20160816;
        b=dLfL65f2937qGw+HfH/QjbihjJWs+LKCz8mrm52v4QdHmt/m3ENCu/sspZWbIXUZkn
         kyHuFt/i9HdYI+ZjJRJbCmiiYo3G1A2vtRzAZpZS8xEz6/MwTKvzKAEiilGnZEzR70Ai
         TPlIUgTPM6np50pyiknBHLpdq7CPeGgqsn36bovZODZb3zRwSefT5ljXlAhAI+ChG8dp
         JnylzQ2gbD3zI3ApQE8UGmD0hJmTOb8j0DODRaiLx16mknlRr27IgeOrMsqkiwR3biOP
         HjMxKSD+m81CX6MbmvQXOw12S5+A8bhDPyUOEHXezTV3LOjSeqbNOJ73XoVE1hUkTfXV
         lr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0E8/jZiLDoptuLtQmGRCrkArHnJxCGnHpOuXv6Pxt0s=;
        b=AKY9VzXHrnKvPejVte4N9kH/ZdRb5HWkqCTPcAsieevQ6ym/tT3D5rlaKzSCaOpwyF
         3HhN31Gac29pFc+HALV6js8EfbKN9j5yzp40lVfo962ZH7vhRjDEetSFRqzkyL3lyzWJ
         AAF/SIBtcgI0HXsGVcbGcwXx8BRJbBNDibUDmXpfHYeiYrPfoDXJKS+CWv2xJ0MP6qeT
         e3ehTFpUn+Cg83b3S6l9v2Yai9a8bOn/Svs3CL8RKGv/z6p3sIlvx7qkGXoV/T5bhpZy
         Ffc1LdZQTRDVSPw7ayyqpprQTZJo8XRWkxmJGy4yyIwFiS234Tou5sHT8dIhBilyEuKP
         8sGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@networkplumber-org.20150623.gappssmtp.com header.s=20150623 header.b=Efrthhc1;
       spf=pass (google.com: domain of stephen@networkplumber.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=stephen@networkplumber.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@networkplumber-org.20150623.gappssmtp.com header.s=20150623 header.b=Efrthhc1;
       spf=pass (google.com: domain of stephen@networkplumber.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=stephen@networkplumber.org
X-Google-Smtp-Source: AH8x226OHNCRcyFpufh69GxMY1+vXGtDfy9Zl+Upoky9FWz7rFv2kl/E741E/TVkpmAD0iWMSyIWDA==
Date: Tue, 13 Feb 2018 09:34:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michael Kelley <mhkelley@outlook.com>
Cc: "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "leann.ogasawara@canonical.com"
 <leann.ogasawara@canonical.com>, "marcelo.cerri@canonical.com"
 <marcelo.cerri@canonical.com>, "sthemmin@microsoft.com"
 <sthemmin@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>
Subject: Re: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Message-ID: <20180213093439.3698cb5e@xeon-e3>
In-Reply-To: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
References: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592048464766251915?=
X-GMAIL-MSGID: =?utf-8?q?1592308043463631980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


>  	if (rbi->ring_buffer->feature_bits.feat_pending_send_sz) {
>  		u32 pending_sz = READ_ONCE(rbi->ring_buffer->pending_send_sz);
>  
>  		/*
> +		 * Ensure the read of write_index in hv_get_bytes_to_write()
> +		 * happens after the read of pending_send_sz.
> +		 */
> +		virt_rmb();
> +		curr_write_sz = hv_get_bytes_to_write(rbi);
> +
> +		/*
>  		 * If there was space before we began iteration,
>  		 * then host was not blocked. Also handles case where
>  		 * pending_sz is zero then host has nothing pending
>  		 * and does not need to be signaled.
>  		 */
> -		if (orig_write_sz > pending_sz)
> +		if (curr_write_sz - delta > pending_sz)
>  			return;
>  
>  		/* If pending write will not fit, don't give false hope. */
> -		if (hv_get_bytes_to_write(rbi) < pending_sz)
> +		if (curr_write_sz <= pending_sz)
>  			return;
> +
> +		vmbus_setevent(channel);
>  	}
>  
> -	vmbus_setevent(channel);
>  }

I think this won't work on older versions of Windows where feat_pending_sz
is never set.  On those versions vmbus_setevent needs to always be called.

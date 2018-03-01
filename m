Return-Path: <why2jjj.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519942224; cv=none;
        d=google.com; s=arc-20160816;
        b=XXhikoUlF8ll09lR12DFLD42eS0LmhSnJJHwfp7HwFXdYa9LNP6HXF61sLT2q0wzTh
         2C4m4TuKRlcb/U+577m27+tJvYFBEA9jmOx9t5+RHTc/7R1kiwPLPcN0xWPg/hSF0DqX
         A+lEy/o2Sx1QBmPkh6ddXpEpvlvJZ6AR5ObnTqgwfNPe6vl8UfEciyWB2ja/HViJHYW9
         gNqNU++5KZB/F623wpLOPPGtNryLm913aet897pwx2UESL7wJEeA8szwFdaojElJgLkH
         XkD1vt3Br3uecC5Oo/03erxWiecapnT94whW5BEZI1pg3JVNyWPs6bvMO/MVum98nHyG
         U7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=TH3Wa0W5IaE7eOpLTmPFxIOWDOqb7i8Cx2oW2zfibtw=;
        b=hyhTgIUAWSGZuS0woiXzwUXCluFiuu7qDITN6gglMpFWzkSnpx8CnNeyTX5vAHdTYg
         mTTEZf+UlXL1BTMHUXiGz301AKDGjapdOcU8WveLD3hoOiiLH8WuST4806gP+n/OySpx
         wfd5mZHuiat2KbidV38XhzFFDIfCD6lRY91gK1xBQzRjXlJf95uqLbzXQ40/q0joNOXA
         YA3Vua6HE9YiEva8Hzg/yJcVMO2A6RQst/l/j2eoLDNfb9Or768emJo55A1ue7AopWPv
         YWLurGuc05uXiQ3l6q1yIh1mn9FSTDlScDG5YnFWGjHFgz1au4I5JixD3BNdKB3/ZIRh
         YyaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hqtfZkwb;
       spf=pass (google.com: domain of why2jjj.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=why2jjj.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hqtfZkwb;
       spf=pass (google.com: domain of why2jjj.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=why2jjj.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuw55OELoz3/+tj7crQ37g72RaRlW5tLGZKC6KhLi+/7iHx5iZ/TpD0tUK6oWdQTbf09u0E3w==
Subject: Re: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
Date: Thu, 1 Mar 2018 14:10:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1593774938183541287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

.
.
.
I'm new to this area of the kernel, but I'm not getting these lines:

> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	tpm_buf_destroy(&buf);
>   	if (rc <  0)
Why is this if() check not directly after the tpm_transmit_cmd() call 
that sets rc?  Is it correct you want to destroy buf regardless of the 
tpm_transmit_cmd() outcome?
>   		return rc;
> -
> -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> +	out = (struct tpm_output_header *)buf.data;

So buf has been destroyed, buf.data sill has something valid to assign 
to out?
> +	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
>   		chip->flags |= TPM_CHIP_FLAG_TPM2;
>   
>   	return 0;
Thanks,
Jay

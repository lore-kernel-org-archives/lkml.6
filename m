Return-Path: <alexey.skidanov@intel.com>
X-Google-Smtp-Source: AH8x227a3OsmyC1lMOlSU671pxfHXXroyTQnyOnKNpm7Wa4LDr4efx+zyYAcOSxckDVW8H+jItjV
ARC-Seal: i=1; a=rsa-sha256; t=1517465395; cv=none;
        d=google.com; s=arc-20160816;
        b=R93b/wJ3Z9Me/xl5EJKDrtuSez/bCEHz5yKGc/TcJZsYYsVn4RhT+FtZus0Y4XUEdA
         FbXCh5vUZqK0SAobq7ZtmnIqdyEyW1YPjNca+3eg79L1xGuudvD64vAyFQMCETQ6ksjW
         8uqkc3I3WemavlhG67or1FrU0ntYnWNJCc6HApuMqIRsgimoykkXBdjpKw7V9JwkY1DD
         56IJqQonJIxkdYrH+flVrZFI4LkPWQx6EwF9VlX2JrKz/c1brecwErlxNKVG5Q1c6yPp
         dZQcv31fiGK9nT8yM9xuIC3d3+uEPIbH73tUCxISPgI9gOb/0aV0gsLsTX7UXRviuoz2
         C2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=6GnDEZpDJrAdfwrh0xhpT0HhmX+Hks47vEODbI4Vynk=;
        b=sC3VgG+BzC6SnaPynoZG6xM4NhXWziD+Zey/rdioZrn/XutY0q8nmqy6Vm+mF87Huc
         p8PaK0TV7KLc9xJS72l4byRJ9FqXJzb/DjSh1I2WnVwA8/cSD6toswahpbmckwm+IZTf
         T78QtIEU5PjLeVN3ifT7TYqEQDn3lYP/QbU1a6YVXGkQ8vJQP4UH5TUq/SiJBhE5xqgZ
         /h1b5itdBeXhHouUJC7X54qhgIgrdGgE3FpqFY3XjP00tEdArlzJsW6kt+tT8S1uH1gN
         J1xIa5jf61hygqvJ1VhPgbOKu4t6DwY9GXdoVfQOoqI+CG1VpFClRk76ptFTsSCeoW+Q
         BsRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexey.skidanov@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=alexey.skidanov@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexey.skidanov@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=alexey.skidanov@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,443,1511856000";
   d="scan'208";a="27156581"
Subject: Re: [PATCH v3] staging: android: ion: Add implementation of
 dma_buf_vmap and dma_buf_vunmap
To: Greg KH <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, labbott@redhat.com, tkjos@android.com,
 rve@android.com, linux-kernel@vger.kernel.org, maco@android.com,
 sumit.semwal@linaro.org
References: <1517400222-2854-1-git-send-email-alexey.skidanov@intel.com>
 <20180131130047.GA22917@kroah.com>
From: Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <89be45dd-ac0e-4efb-2b21-e6c07b0cd66e@intel.com>
Date: Thu, 1 Feb 2018 08:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180131130047.GA22917@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591109503964989567?=
X-GMAIL-MSGID: =?utf-8?q?1591177794594600196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 01/31/2018 03:00 PM, Greg KH wrote:
> On Wed, Jan 31, 2018 at 02:03:42PM +0200, Alexey Skidanov wrote:
>> Any driver may access shared buffers, created by ion, using dma_buf_vmap and
>> dma_buf_vunmap dma-buf API that maps/unmaps previosuly allocated buffers into
>> the kernel virtual address space. The implementation of these API is missing in
>> the current ion implementation.
>>
>> Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
>> ---
> 
> No review from any other Intel developers? :(
Will add.
> 
> Anyway, what in-tree driver needs access to these functions?
I'm not sure that there are the in-tree drivers using these functions 
and ion as buffer exporter because they are not implemented in ion :) 
But there are some in-tree drivers using these APIs (gpu drivers) with 
other buffer exporters.
> 
> And are you sure that you don't need to do any "real" logic in the
> vmap/vunmap calls?  That feels like there would be some reference
> counting problems here.
dma_buf_start_cpu_access is called before the call to dma_buf_vmap. It 
actually increments the reference count. dma_buf_end_cpu_access is 
called after the dma_buf_vunmap. It actually decrements the reference 
count.>>
>> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
>> index f480885..4f1dc7f 100644
>> --- a/drivers/staging/android/ion/ion.c
>> +++ b/drivers/staging/android/ion/ion.c
>> @@ -327,6 +327,17 @@ static void ion_dma_buf_kunmap(struct dma_buf *dmabuf, unsigned long offset,
>>   {
>>   }
>>   
>> +static void *ion_dma_buf_vmap(struct dma_buf *dmabuf)
>> +{
>> +	struct ion_buffer *buffer = dmabuf->priv;
>> +
>> +	return buffer->vaddr;
> 
> Just call ion_dma_buf_kmap(dmabuf, 0)?
Sure.
> 
> Again, please get this reviewed by someone else in Intel first.  Don't
> ignore the resources you have, to do so would be foolish :)
Sure. Will do.
> 
> thanks,
> 
> greg k-h
> 

Thanks,
Alexey

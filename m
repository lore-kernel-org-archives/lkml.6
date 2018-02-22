Return-Path: <xieyisheng1@huawei.com>
X-Google-Smtp-Source: AH8x2263cWwc/EG4VGRZEEPLzAlN6VILm/og5uIkopWZDCDrqE7qHz82/qxw09dDw4BYYSE3b2MN
ARC-Seal: i=1; a=rsa-sha256; t=1519289992; cv=none;
        d=google.com; s=arc-20160816;
        b=u/bZZrcV8yLCgb8PXsib6EeSklKD+pofRoyRe18b93gZ0xGGjdNMO1ZuNDtTh4okyk
         i3TXLr6KFYY49rczT5rverukXfufNPNo8B8vJEsMNnNyca+0+cIZmj8ro/+AQuuAKdSz
         VUjrCqrqRsVhQO3/SjKKy39muOevilS+/OaQdtVu6GPOKPdjoMofIN1IuZusWuEfkXz4
         7jRN5ZmKYVytHHfY3GHLgC04RNbmYCSZ2BTSOXDBYtdkACe402fWqaeUYb2TllzKIzCY
         T2DuH/F92Ep1CZcyB8NmNL7NzTatSOQGps+YGbKVbeMom/jbdyoGIIVjffm/ICAFwpuA
         Wk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=ZWJxv9Cm9Tfh1+X0jjlyN1eIcNIq4G/8a4gf/DGpmvc=;
        b=TiCXa5Na+WLrHe2GXer/5LfJjom6L5g2xIy1c9JbT7mHvomdtX4r6M/nA2/q214ETm
         Oan7w+9CJ4AhXbnWjd8UcUj9dmRQAO/vKnE0JTQXndM/hOQB+g6BfvYa79CkfyQBWu+r
         iZy8adktqhtICQYpEn1V2qIPCGe5rm6d06myS7Hq9fIRL5+Wy3C5oEpVxV4YkKXvuZz/
         dBIMyNpxoQ165wjtETEjoC3LmstBx39vVr0yHhVEXKJbw4fQehYkBLfXDc9m4DBV1n95
         iMu3InKI3tm76WT3bCS+2TTvatT74EOOT+OMSWTWtJlZnzujXqkh4qo7fjw2JoMZxolW
         M1QQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Subject: Re: [PATCH v2 4/9] staging: android: ion: Avoid NULL point in error
 path
To: Greg KH <gregkh@linuxfoundation.org>
References: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
 <1518432194-41536-5-git-send-email-xieyisheng1@huawei.com>
 <20180216162732.GA18688@kroah.com>
CC: <labbott@redhat.com>, <sumit.semwal@linaro.org>,
	<devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <844e0fa1-cd03-8e2e-4a3e-6021a79610b4@huawei.com>
Date: Thu, 22 Feb 2018 16:59:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20180216162732.GA18688@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592192148459157158?=
X-GMAIL-MSGID: =?utf-8?q?1593091023684164373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Sorry for late responds for I was on vacation.

On 2018/2/17 0:27, Greg KH wrote:
> On Mon, Feb 12, 2018 at 06:43:09PM +0800, Yisheng Xie wrote:
>> If we failed to create debugfs for ion at ion_device_create, the
>> debug_root of ion_device will be NULL, and then when try to create debug
>> file for shrinker of heap it will be create on the top of debugfs. If we
>> also failed to create this the debug file, it call dentry_path to found
>> the path of debug_root, then a NULL point will occur.
>>
>> Fix this by avoiding call dentry_path, but show the debug name only when
>> failed to create debug file for shrinker.
>>
>> Acked-by: Laura Abbott <labbott@redhat.com>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>  drivers/staging/android/ion/ion.c | 10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
>> index 57e0d80..4b69372 100644
>> --- a/drivers/staging/android/ion/ion.c
>> +++ b/drivers/staging/android/ion/ion.c
>> @@ -564,13 +564,9 @@ void ion_device_add_heap(struct ion_heap *heap)
>>  		debug_file = debugfs_create_file(debug_name,
>>  						 0644, dev->debug_root, heap,
>>  						 &debug_shrink_fops);
>> -		if (!debug_file) {
>> -			char buf[256], *path;
>> -
>> -			path = dentry_path(dev->debug_root, buf, 256);
>> -			pr_err("Failed to create heap shrinker debugfs at %s/%s\n",
>> -			       path, debug_name);
>> -		}
>> +		if (!debug_file)
>> +			pr_err("Failed to create ion heap shrinker debugfs at %s\n",
>> +			       debug_name);
> 
> Really we can just remove this, there's no need to check the return
> value of this debugfs call at all, it doesn't matter.

Right, and I found that you have already patched this patch into next, should I send
another version for the two patches your commented, or just send fix patches to fold?

Thanks
Yisheng
> 
> thanks,
> 
> greg k-h
> 
> .
> 

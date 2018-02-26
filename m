Return-Path: <jsarha@ti.com>
X-Google-Smtp-Source: AG47ELsNo1TFl+rSiGqJZ40WM88JWqY3WjSg7traxDFJiNzDVlT/Fz5E7m7sAKwwwjBiRwlGHYOO
ARC-Seal: i=1; a=rsa-sha256; t=1519631550; cv=none;
        d=google.com; s=arc-20160816;
        b=iR3DHhgjQpDkbVV4zzpKM1OerCI3sm9f/E8bW13XTh5h2RN0cSyIeae6gtJfdouP0G
         cYVo8+1zbWPJLpGqI1iZ+mnOaWbLtGkrVGOSCWdX0bYiCl1hulWlR+vNJftafY1jTjux
         6nf1V++94WO8XZh0IQeucS6dX2YmvgENfy7Sz9/3Yb7rXo008XYcW6eR9Cxlp4Q1fe6T
         nJ/xAuf5atF0qR/W6BB+e6WidA/K7VdN3PJCoW0ke4WXPusHYrrl7l49MZnoxrVmxM9i
         4PSsbTqGJsQX2KIlxRS9/n+yIeRmH1QdF/EZLH1vZ7rjedD3RqhHYeoZcfHP/JTtYkrr
         h5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=4JkTMgaxLW7ZH4/w/Etm7+SPMjEnPBns9+hZaD0Av1g=;
        b=M+zNQrdPs237p84hYX8teQP7pZuwQ6ZUIDFxXXIo8cCBNg8/X5aoMZ7EUVOpWpk3En
         FZ/j5ph96ZY7+lNrxfVvb3cjGDS8TZAI/z7AI6qkbHdzouyHWJwBR9Mc+UjaGOk3vY0K
         GbW8pKNQ5H8nBx6hLXaMKnfh8Ll7qGPVQAvllh9nQIFGzwdyQNFae1VAKkC8Vl/Ge4FC
         SAX63HopO1TBRYVfOL71FSUeGY5WfuWWqqVEaL86b1457H+A6V8RQhNlBiX6jsC99L6F
         /nu4d/pnnfmxHo3IMdd4gXMJsDdBzH5kDenXtuQC+PbPv3u1YJxh8juDFwIKixbRu9T0
         skxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=WbwRy6Nm;
       spf=pass (google.com: domain of jsarha@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=jsarha@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=WbwRy6Nm;
       spf=pass (google.com: domain of jsarha@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=jsarha@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH RFC] driver core: Reprobe consumer if it was unbound by
 dropped device_link
To: Lukas Wunner <lukas@wunner.de>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ti.com>, <thierry.reding@gmail.com>,
        <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>
References: <cover.1519321145.git.jsarha@ti.com>
 <57c1d52a5a8f5985dc1dd53260d7d68795be8ea2.1519321145.git.jsarha@ti.com>
 <20180225092223.GB923@wunner.de>
From: Jyri Sarha <jsarha@ti.com>
Message-ID: <36c24c0e-59a1-12de-cfff-01c942862349@ti.com>
Date: Mon, 26 Feb 2018 09:52:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225092223.GB923@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593123928219045407?=
X-GMAIL-MSGID: =?utf-8?q?1593449173032657878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 25/02/18 11:22, Lukas Wunner wrote:
> On Thu, Feb 22, 2018 at 07:42:46PM +0200, Jyri Sarha wrote:
>> Put consumer device to deferred probe list if it is unbound due to a
>> dropped link to a supplier.
>>
>> When a device link supplier is unbound (either manually or because one
>> of its own suppliers was unbound), its consumers are unbound as
>> well. Currently if the supplier binds again after this the consumer
>> does not automatically probe again. With this patch it does.
> 
> Yes I think this makes sense, based on the rationale that the consumer
> was automatically unbound, so by symmetry it should also be automatically
> rebound.
> 
> The only thing I don't understand is you wrote in an earlier e-mail of a
> difference in behavior depending on whether driver_deferred_probe_add()
> is called before or after device_release_driver_internal().
> That's really odd, it shouldn't make a difference.
> 

In that version there was a couple of other bugs elsewhere in the
system. I tried to reproduce that situation again multiple times, but I
could not (even write those bugs back in there, and move the link
creation back to panel bridge code). But even from reading the code that
difference did not make any sense. I suspect a heisen-bug, after I have
read the code and understood that the crash is not possible, it does not
happen anymore :).

With the current version I could not find any difference in behaviour
depending on the order of device_release_driver_internal() and
driver_deferred_probe_add() calls. I just thought having them in this
order just lookes nicer.

I stress tested the code by unloading and loading the panel driver in a
tight loop, for several minutes, but it simply wont crash (not in this
setup anyway). The probe of tilcdc eventually gracefully fails in a CMA
failure.

Best regards,
Jyri

> Thanks,
> 
> Lukas
> 
>>
>> If this patch is not acceptable as such, how about adding this
>> behavior behind a new device link flag?
>>
>> The idea to this patch was gotten from this post by Lucas Wunner:
>> https://www.spinics.net/lists/dri-devel/msg166318.html
>>
>> Part of the code and the description is borrowed from him.
>>
>> cc: Lukas Wunner <lukas@wunner.de>
>> cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> cc: Thierry Reding <thierry.reding@gmail.com>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>  drivers/base/base.h | 1 +
>>  drivers/base/core.c | 2 ++
>>  drivers/base/dd.c   | 2 +-
>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>> index d800de6..39370eb 100644
>> --- a/drivers/base/base.h
>> +++ b/drivers/base/base.h
>> @@ -114,6 +114,7 @@ extern void device_release_driver_internal(struct device *dev,
>>  
>>  extern void driver_detach(struct device_driver *drv);
>>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>> +extern void driver_deferred_probe_add(struct device *dev);
>>  extern void driver_deferred_probe_del(struct device *dev);
>>  static inline int driver_match_device(struct device_driver *drv,
>>  				      struct device *dev)
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index b2261f9..0964ed5 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -570,6 +570,8 @@ void device_links_unbind_consumers(struct device *dev)
>>  
>>  			device_release_driver_internal(consumer, NULL,
>>  						       consumer->parent);
>> +			driver_deferred_probe_add(consumer);
>> +
>>  			put_device(consumer);
>>  			goto start;
>>  		}
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index de6fd09..846ae78 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -140,7 +140,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
>>  
>> -static void driver_deferred_probe_add(struct device *dev)
>> +void driver_deferred_probe_add(struct device *dev)
>>  {
>>  	mutex_lock(&deferred_probe_mutex);
>>  	if (list_empty(&dev->p->deferred_probe)) {


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

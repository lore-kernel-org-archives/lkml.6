Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZpRAG7NcHh5jczmhetMUcrWYF9eKBDqkO1jLTYYo3fVXibJPj+cmYJtRE4R8sNqHqZjk3K+
ARC-Seal: i=1; a=rsa-sha256; t=1526316885; cv=none;
        d=google.com; s=arc-20160816;
        b=dz+UuCBfFubFk+4V9nZOz6C1pRl7Bh0JwJYZdZAJaUEDWofvbIOgRzL3Vc3n1uPMzM
         76Rrsz914qZpXm9tSYQ4emLCNsn9T0zPUZVSsZU148aZTOeMMebAFQLw+WkYGR+CktWg
         EcHwEkSzC8ZNqIGy2x/eU9N3kDGbDo5+Za2giHiB0fgsm4EcNgdUomDhjAgnf5wULJp+
         O76gySpkHA0ig7jE4BKJKBopzGIK35CvPJYdTIaIB8BcQcwjHPhkUt6EfvmYJ39i+vYz
         n0UI9Xp7D/36U5o+80rpnNu81MFaCaKF3DZeXZDrFgTIvcYcAb2VmnGLnkZ/hpwzOtem
         8OFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=97RyYdPQUHqzpQQAJbxFAxILE4wkRZ8WefP4rmZOrqs=;
        b=hsVjihKJoGhU8kqp27xU2yigrNUUmh/4EX/uEZlqs5cTmrx9nCFwII4iNbDvokhGFP
         jseC939QOhQWlg7wWpokO1AWm1KtH53xsZRwor53H25DAsvZH8tAOYf05BEjW2P9n3BA
         8W83SeGYurrhJJ9TRHPxv2x/gr6J0fGlUmGleVABCBBWZRUok75ue5QBpVs2C0KZwhn8
         diSgQO+SyzEPslQnk+kewim7QAQ1HgHQ3wkGcdcXecXOf7X7wpAh0IaQ/vbxXm6R89RS
         8AHf85tEkT97XWt1FF8pS5XJ9w1Ku++oJHWJHmYmfcASHWEwjuoRZoqo4wPdAeZABmPW
         ay2w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=BXKkiqOZ;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=BXKkiqOZ;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v3 0/1] multi-threading device shutdown
To: Greg KH <gregkh@linuxfoundation.org>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        alexander.duyck@gmail.com, tobin@apporbit.com
References: <20180507155402.10086-1-pasha.tatashin@oracle.com>
 <20180514150336.GA18769@kroah.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <ca8b0bf8-e848-be2a-c9f5-b01ee65551b3@oracle.com>
Date: Mon, 14 May 2018 12:54:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514150336.GA18769@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805140171
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599821267114231354?=
X-GMAIL-MSGID: =?utf-8?q?1600459254333557126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 11:03 AM, Greg KH wrote:
> On Mon, May 07, 2018 at 11:54:01AM -0400, Pavel Tatashin wrote:
>> Changelog
>> v2 - v3
>> 	- Fixed warning from kbuild test.
>> 	- Moved device_lock/device_unlock inside device_shutdown_tree().
>>
>> v1 - v2
>> 	- It turns out we cannot lock more than MAX_LOCK_DEPTH by a single
>> 	  thread. (By default this value is 48), and is used to detect
>> 	  deadlocks. So, I re-wrote the code to only lock one devices per
>> 	  thread instead of pre-locking all devices by the main thread.
>> 	- Addressed comments from Tobin C. Harding.
>> 	- As suggested by Alexander Duyck removed ixgbe changes. It can be
>> 	  done as a separate work scaling RTNL mutex.
>>
>> Do a faster shutdown by calling dev->*->shutdown(dev) in parallel.
>> device_shutdown() calls these functions for every single device but
>> only using one thread.
>>
>> Since, nothing else is running on the machine by the device_shutdown()
>> s called, there is no reason not to utilize all the available CPU
>> resources.
> 
> Ah, we can hope so.  I bet this is going to break something, so can we
> have some way of turning it on/off dynamically for when it does?

Hi Greg,

Sure, I will add a kernel parameter to optionally disable this feature in the next patch revision.

Thank you,
Pavel

> 
> thanks,
> 
> greg k-h
> 

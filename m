Return-Path: <srivatsa@csail.mit.edu>
X-Google-Smtp-Source: AG47ELswqIXmbtFA91HAs9QBJ9iHi7QXOP2ky9TswjOWwJeE6ZisVq4icE8QG/cc4WvbHkSRaShK
ARC-Seal: i=1; a=rsa-sha256; t=1519723388; cv=none;
        d=google.com; s=arc-20160816;
        b=B6D6Qktufxom/0qM+Y4s4IORbF4wW+vKcvK3jDIFsbU1vs19jsv8103apqzsPayUyA
         ENOKkixNt2+hVwHj2bIDgsVNlgEihPS41pKKbEIAipK12CSQj5cAARTCKY9kRM/Nq4c+
         eJ55UWykQI/hPvHg9hXjL9Tymzi7veBtistK0Zv2SqfFUpdzzAFe+LWj22BctXmYUQqd
         akpeEKKwJ7VpuSHg0HJWs5/+mEBHo6ffhvyxjXZ+g+GNU6nYwagTAA+evc4csWKaNslH
         CB61g/peQ9PMyup8/XPYgYTTUai5X5wYbH9gcIoZsy27J2APQf8Tz5fAhIFz184iBpWK
         Qfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=je2ffWiC12gR4053iA58VYcGF8xuvwU3LA2rxmLEs5E=;
        b=xepAcovr8MFtb9Syelux2U6q0SpVFVKL5Je/bAhW/0u+z/1S4mWGmUCT1+l9a5pHbC
         RGMx7kHu9297MScT4xSdCrLsdqThMRdkADw6fyBYZBLw5NSkOC4g86QW46OEG6pmH+09
         TSAmAt4GI3Etq9Sq9qiaFGZcTH9o9kEezDbZhZeQQp8BYBeRTlmjpzryXiAWq/rhYw3c
         WOEGV2Z6gp8JzOUq6g9ndSqNld87xVjWr+3TnZMm02YlBVc34C4SrZxPbsNjxfZHn8KL
         pb4wAbPHBQ7tLjgsuT53Az6EO+WN728+1HDq3Yp12W3e3dSO2H3rfDYkftfBxM6UEcID
         ZG0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Backlund <tmb@mageia.org>, Steve French <smfrench@gmail.com>,
 =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, lsahlber@redhat.com,
 pshilov@microsoft.com, linux-cifs@vger.kernel.org
References: <20171031095530.520746935@linuxfoundation.org>
 <20171031095531.633196173@linuxfoundation.org>
 <97340c9a-0ea2-0d3d-cf26-58c799d76cae@mageia.org>
 <20171101151803.GB31285@kroah.com>
 <4ba67095-4075-688f-d3fb-157847aee4d9@csail.mit.edu>
 <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
 <20180227085428.GA16879@kroah.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
Date: Tue, 27 Feb 2018 01:22:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227085428.GA16879@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1582766661007473179?=
X-GMAIL-MSGID: =?utf-8?q?1593545471494314071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/27/18 12:54 AM, Greg Kroah-Hartman wrote:
> On Mon, Feb 26, 2018 at 07:44:28PM -0800, Srivatsa S. Bhat wrote:
>> On 1/3/18 6:15 PM, Srivatsa S. Bhat wrote:
>>> On 11/1/17 8:18 AM, Greg Kroah-Hartman wrote:
>>>> On Tue, Oct 31, 2017 at 03:02:11PM +0200, Thomas Backlund wrote:
>>>>> Den 31.10.2017 kl. 11:55, skrev Greg Kroah-Hartman:
>>>>>> 4.13-stable review patch.  If anyone has any objections, please let me know.
>>>>>>
>>>>>> ------------------
>>>>>>
>>>>>> From: Steve French <smfrench@gmail.com>
>>>>>>
>>>>>> commit 4587eee04e2ac7ac3ac9fa2bc164fb6e548f99cd upstream.
>>>>>>
>>>>>> According to MS-SMB2 3.2.55 validate_negotiate request must
>>>>>> always be signed. Some Windows can fail the request if you send it unsigned
>>>>>>
>>>>>> See kernel bugzilla bug 197311
>>>>>>
>>>>>> Acked-by: Ronnie Sahlberg <lsahlber.redhat.com>
>>>>>> Signed-off-by: Steve French <smfrench@gmail.com>
>>>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>
>>>>>> ---
>>>>>>   fs/cifs/smb2pdu.c |    3 +++
>>>>>>   1 file changed, 3 insertions(+)
>>>>>>
>>>>>> --- a/fs/cifs/smb2pdu.c
>>>>>> +++ b/fs/cifs/smb2pdu.c
>>>>>> @@ -1963,6 +1963,9 @@ SMB2_ioctl(const unsigned int xid, struc
>>>>>>   	} else
>>>>>>   		iov[0].iov_len = get_rfc1002_length(req) + 4;
>>>>>> +	/* validate negotiate request must be signed - see MS-SMB2 3.2.5.5 */
>>>>>> +	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO)
>>>>>> +		req->hdr.sync_hdr.Flags |= SMB2_FLAGS_SIGNED;
>>>>>>   	rc = SendReceive2(xid, ses, iov, n_iov, &resp_buftype, flags, &rsp_iov);
>>>>>>   	cifs_small_buf_release(req);
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>> This one needs to be backported to all stable kernels as the commit that
>>>>> introduced the regression:
>>>>> '
>>>>> 0603c96f3af50e2f9299fa410c224ab1d465e0f9
>>>>> SMB: Validate negotiate (to protect against downgrade) even if signing off
>>>>>
>>>>> is backported in stable trees as of: 4.9.53, 4.4.90, 3.18.73
>>>>
>>>> Oh wait, it breaks the builds on older kernels, that's why I didn't
>>>> apply it :)
>>>>
>>>> Can you provide me with a working backport?
>>>>
>>>
>>> Hi Steve,
>>>
>>> Is there a version of this fix available for stable kernels?
>>>
>>
>> Hi Greg,
>>
>> Mounting SMB3 shares continues to fail for me on 4.4.118 and 4.9.84
>> due to the issues that I have described in detail on this mail thread.
>>
>> Since there is no apparent fix for this bug on stable kernels, could
>> you please consider reverting the original commit that caused this
>> regression?
>>
>> That commit was intended to enhance security, which is probably why it
>> was backported to stable kernels in the first place; but instead it
>> ends up breaking basic functionality itself (mounting). So in the
>> absence of a proper fix, I don't see much of an option but to revert
>> that commit.
>>
>> So, please consider reverting the following:
>>
>> commit 02ef29f9cbb616bf419 "SMB: Validate negotiate (to protect
>> against downgrade) even if signing off" on 4.4.118
>>
>> commit 0e1b85a41a25ac888fb "SMB: Validate negotiate (to protect
>> against downgrade) even if signing off" on 4.9.84
>>
>> They correspond to commit 0603c96f3af50e2f9299fa410c224ab1d465e0f9
>> upstream. Both these patches should revert cleanly. 
> 
> Do you still have this same problem on 4.14 and 4.15?  If so, the issue
> needs to get fixed there, not papered-over by reverting these old
> changes, as you will hit the issue again in the future when you update
> to a newer kernel version.
> 

4.14 and 4.15 work great! (I had mentioned this is in my original bug
report but forgot to summarize it here, sorry).

Thank you!

Regards,
Srivatsa

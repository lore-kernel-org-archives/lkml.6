Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525791171; cv=none;
        d=google.com; s=arc-20160816;
        b=Qd+Hoa0W8RHMCxvzSUOFKoX4RCIUf9sKlvrr6z2oEdQkmRzniCmnDX7U7jaDPnRvBf
         Zl7IvsixT6rM1B0shVNhtngBBhgx9kYwBNTDKFmzu4Ibgmhe3N4QtUBT2cpJiILoan+t
         45raRBdVi2GvDjCgXQvlbEp+wTXLT2XJNhIr77IJjOLkZPg+o9KiA6v5lXXIWxMFi69V
         i1Xc9kNpprEMWrzCMtVeSfT1Csm2PVXUAA+RiUnmTffmCs0L1mWaBSC5Okz6NRH9F28/
         5DBjStJGs5Jx2nvM454fLzMSUwC9Wym6nbXy4vK/bR4H8kMSwWekd8Uu07rrmb+jcoeL
         FfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=EHellByAN5yp1NEw6QlO7Hleli/k87211LsIX8bdzUQ=;
        b=ZJoVNe51dE+Iw8VmDrtxPt7Jifn5XzQA8wWeL9k91TLDfk8MSHkvPnwbDI7bsVNO5Y
         pv0bBoRSL4fo4rcPGZNVX0ZTk31VnN/aBFiI5GduEo5OjLVPQ0xLM53uFZRqh4HN7ml/
         iaha/vFDxSo++7mU3V4ILZs1fFLjlN/1tdcgOIrKC0wNaqUVLrRkfi+emDEdXAl/m5Ey
         CXMBPKtieLndrRJRUzVDxFLG6s1QSpUs+DKjjrQmKYzqa3nS2T0VLUoaYXxVMFdvML6N
         Pv5N+zA4C/6/QcMbXPdHn/FIv2XADiYD8r42qzEBa+KAcMgVZVi6qR+W2Aj58qAR/G1e
         OY2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZpHUViwFdklRWnvvcuXQEx8i3qMHeEFc6tiaSrE3OytkpjRDHuqebeLFhDsRu3lme+33ea2mg==
Subject: Re: [PATCH] virt: vbox: Only copy_from_user the request-header once
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20180508134659.20429-1-hdegoede@redhat.com>
 <20180508142117.GB10972@kroah.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <4f440336-608a-33a8-108a-8c53665a103a@redhat.com>
Date: Tue, 8 May 2018 16:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508142117.GB10972@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599903862223465156?=
X-GMAIL-MSGID: =?utf-8?q?1599908003003123366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 08-05-18 16:21, Greg Kroah-Hartman wrote:
> On Tue, May 08, 2018 at 03:46:59PM +0200, Hans de Goede wrote:
>> In vbg_misc_device_ioctl(), the header of the ioctl argument is copied from
>> the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
>> 'version', 'size_in', and 'size_out' fields of 'hdr' are verified.
>>
>> Before this commit, after the checks a buffer for the entire request would
>> be allocated and then all data including the verified header would be
>> copied from the userspace 'arg' pointer again.
>>
>> Given that the 'arg' pointer resides in userspace, a malicious userspace
>> process can race to change the data pointed to by 'arg' between the two
>> copies. By doing so, the user can bypass the verifications on the ioctl
>> argument.
>>
>> This commit fixes this by using the already checked copy of the header
>> to fill the header part of the allocated buffer and only copying the
>> remainder of the data from userspace.
>>
>> Reported-by: Wenwen Wang <wang6495@umn.edu>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Does this need to go into 4.17-final?  Any older kernels?  Or can it
> wait for 4.18-rc1?

I believe this can wait for 4.18-rc1.

Regards,

Hans

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeESBUK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 21:20:10 -0400
Received: from p3plsmtpa08-07.prod.phx3.secureserver.net ([173.201.193.108]:53086
        "EHLO p3plsmtpa08-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752042AbeESBUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 21:20:07 -0400
Subject: Re: [RFC PATCH 09/09] Introduce cache=rdma moutning option
To: Long Li <longli@microsoft.com>, Steve French <smfrench@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
 <20180518002214.5657-10-longli@linuxonhyperv.com>
 <20180518072631.GA19250@infradead.org>
 <MWHPR2101MB07297B07D495D66A1C9416FACE900@MWHPR2101MB0729.namprd21.prod.outlook.com>
 <CAH2r5mtzUJUakbPr_kzrDcqVPC9QuS7K8MXejNz7F=Uii6K5Kg@mail.gmail.com>
 <MWHPR2101MB0729D163B903A0198A85AB4BCE900@MWHPR2101MB0729.namprd21.prod.outlook.com>
From: Tom Talpey <tom@talpey.com>
Message-ID: <9b1496c1-a2ae-d724-fa0a-518a87be09c1@talpey.com>
Date: Fri, 18 May 2018 18:20:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR2101MB0729D163B903A0198A85AB4BCE900@MWHPR2101MB0729.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF8jWVOPTAORPlBMtfm4bYQPtXfz525AmwYVWxqRz6WOcWk//2+3EVzbBoPoPJUP+JEsV6/0Ta2Fwl8rig4R8GVmsq6caO/myjxMUJxjghnJY5OtwC3X
 8mn5R0DgQ1njpeYtg4MigyC1dyYN7UVjpRoAcjyrV2YMfYu7+S6kOopUkGXozHNB9NxJaHKaT2yYa8UNi5vqCEV4Vu8kTvIcxbujU1gV0qdQKf9jOLnLl0nD
 fHPhQuepuG4+s0y4oP51EA4lyBGWg6tiN4efX+5Y1uAcKqzvOSxIQQFHXyiymfKP6JhN3sjgrrArTiX4ro0prO8bpqR7YNNSB6u9bbglIGqbZjEnVDcw1N8f
 wOLp6OP2Ubiic/eLPUsI+dQ5ev/BCP0BGoCjwRaCvPd8ujZo83tuoQYBvR7lcEGKeBl7JpC5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2018 1:58 PM, Long Li wrote:
>> Subject: Re: [RFC PATCH 09/09] Introduce cache=rdma moutning option
>>
>> On Fri, May 18, 2018 at 12:00 PM, Long Li via samba-technical <samba-
>> technical@lists.samba.org> wrote:
>>>> Subject: Re: [RFC PATCH 09/09] Introduce cache=rdma moutning option
>>>>
>>>> On Thu, May 17, 2018 at 05:22:14PM -0700, Long Li wrote:
>>>>> From: Long Li <longli@microsoft.com>
>>>>>
>>>>> When cache=rdma is enabled on mount options, CIFS do not allocate
>>>>> internal data buffer pages for I/O, data is read/writen directly to
>>>>> user
>>>> memory via RDMA.
>>>>
>>>> I don't think this should be an option.  For direct I/O without
>>>> signing or encryption CIFS should always use get_user_pages, with or
>> without RDMA.
>>>
>>> Yes this should be done for all transport. If there are no objections, I'll send
>> patches to change this.
>>
>> Would this help/change performance much?
> 
> On RDMA, it helps with I/O latency and reduces CPU usage on certain I/O patterns.
> 
> But I haven't tested on TCP. Maybe it will help a little bit.

Well, when the application requests direct i/o on a TCP connection,
you definitely don't want to cache it! So even if the performance
is different, correctness would dictate doing this.

You probably don't need to pin the buffer in the TCP case, which
might be worth avoiding.

Tom.

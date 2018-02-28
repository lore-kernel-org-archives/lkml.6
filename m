Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeB1CNq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:13:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751682AbeB1CNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:13:45 -0500
Subject: Re: [V9fs-developer] [PATCH] net/9p: avoid -ERESTARTSYS leak to
 userspace
References: <151811152925.12219.16418114797025615002.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20180220174816.0ef05769@bahia.lan>
CC: <v9fs-developer@lists.sourceforge.net>, <lucho@ionkov.net>,
        <ericvh@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rminnich@sandia.gov>,
        <davem@davemloft.net>, Greg Kurz <groug@kaod.org>
To: <viro@zeniv.linux.org.uk>
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5A961047.8000905@huawei.com>
Date: Wed, 28 Feb 2018 10:13:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180220174816.0ef05769@bahia.lan>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

I totally agree the Greg's suggestion, I think v9fs is the direction
as the VirtFS in the virtualization field, that it still deserves to
be used and developed, so I also suggestion you can apply (or nack)
the patch as v9fs maintainer, I hope you won't refuse.

Thanks,
Yiwen.

On 2018/2/21 0:48, Greg Kurz wrote:
> Hi Al,
> 
> It's been two years without any sign of life from 9p maintainers... :-\
> 
> Would you apply (or nack) this patch ?
> 
> Thanks,
> 
> --
> Greg
> 
> PS: in the case you apply it, probable Cc stable@vger.kernel.org as well
> 
> 
> On Thu, 08 Feb 2018 18:38:49 +0100
> 
> Greg Kurz <groug@kaod.org> wrote:
> 
>> If it was interrupted by a signal, the 9p client may need to send some
>> more requests to the server for cleanup before returning to userspace.
>>
>> To avoid such a last minute request to be interrupted right away, the
>> client memorizes if a signal is pending, clear TIF_SIGPENDING, handle
>> the request and call recalc_sigpending() before returning.
>>
>> Unfortunately, if the transmission of this cleanup request fails for any
>> reason, the transport returns an error and the client propagates it right
>> away, without calling recalc_sigpending().
>>
>> This ends up with -ERESTARTSYS from the initially interrupted request
>> crawling up to syscall exit, with TIF_SIGPENDING cleared by the cleanup
>> request. The specific signal handling code, which is responsible for
>> converting -ERESTARTSYS to -EINTR is not called, and userspace receives
>> the confusing errno value:
>>
>> open: Unknown error 512 (512)
>>
>> This is really hard to hit in real life. I discovered the issue while
>> working on hot-unplug of a virtio-9p-pci device with an instrumented
>> QEMU allowing to control request completion.
>>
>> Both p9_client_zc_rpc() and p9_client_rpc() functions have this buggy
>> error path actually. Their code flow is a bit obscure and the best
>> thing to do would probably be a full rewrite: to really ensure this
>> situation of clearing TIF_SIGPENDING and returning -ERESTARTSYS can
>> never happen.
>>
>> But given the general lack of interest for the 9p code, I won't risk
>> breaking more things. So this patch simply fix the buggy paths in both
>> functions with a trivial label+goto.
>>
>> Thanks to Laurent Dufour for his help and suggestions on how to find
>> the root cause and how to fix it.
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>> ---
>>  net/9p/client.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 4c8cf9c1631a..5154eaf19fff 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -769,7 +769,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>>  	if (err < 0) {
>>  		if (err != -ERESTARTSYS && err != -EFAULT)
>>  			c->status = Disconnected;
>> -		goto reterr;
>> +		goto recalc_sigpending;
>>  	}
>>  again:
>>  	/* Wait for the response */
>> @@ -804,6 +804,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>>  		if (req->status == REQ_STATUS_RCVD)
>>  			err = 0;
>>  	}
>> +recalc_sigpending:
>>  	if (sigpending) {
>>  		spin_lock_irqsave(&current->sighand->siglock, flags);
>>  		recalc_sigpending();
>> @@ -867,7 +868,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>>  		if (err == -EIO)
>>  			c->status = Disconnected;
>>  		if (err != -ERESTARTSYS)
>> -			goto reterr;
>> +			goto recalc_sigpending;
>>  	}
>>  	if (req->status == REQ_STATUS_ERROR) {
>>  		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
>> @@ -885,6 +886,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>>  		if (req->status == REQ_STATUS_RCVD)
>>  			err = 0;
>>  	}
>> +recalc_sigpending:
>>  	if (sigpending) {
>>  		spin_lock_irqsave(&current->sighand->siglock, flags);
>>  		recalc_sigpending();
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> V9fs-developer mailing list
>> V9fs-developer@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/v9fs-developer
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> V9fs-developer mailing list
> V9fs-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/v9fs-developer
> 
> .
> 

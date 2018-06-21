Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3173AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDAE20874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v0ksTz2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDAE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFUBnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:43:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46936 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754079AbeFUBnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:43:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5L1ctjt090420;
        Thu, 21 Jun 2018 01:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=0oc8onGVNrG2A2KLt1WHQPgEhOefu/lGTw8bGGONVg8=;
 b=v0ksTz2ptMYOHUckaZ4SMURzq3EAWEcu6C/6IkTUIFfWIqUrTZn1YmmnjZVt0hQ0wJzT
 GvQJknG8reDMXr1rNiDWlLGwEdTbobIlenbqQ5mnx3VEnCs9AO1I1WsNFLETr2QbSkO/
 1tz/jTGEpG0tUGzPDvKdHgpVMtprnIOsnGpOGSbC7wCTnhrcvUQRUsQ8idFHE6bMa/7o
 8j/LR53+E88Tw2LBPRyXIIfLPiUlNhwLFUcH7vTMe8aA3ctsa+GYSlxiljzgR/aKPAq4
 fgqCwy4SqFR8FzLKkWDhOAA/JCmgwGVbCTdu6gB1G4udohQPnmbaOwTW80lvx04RmJZq pA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jmr2mpy2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 01:43:10 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5L1h9KO012737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 01:43:09 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5L1h82g008994;
        Thu, 21 Jun 2018 01:43:09 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 18:43:08 -0700
Subject: Re: [PATCH 0/5]stop normal completion path entering a timeout req
To:     Keith Busch <keith.busch@intel.com>
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        josef@toxicpanda.com, ulf.hansson@linaro.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180620181601.GA24145@localhost.localdomain>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e87f5946-bb21-942e-2dcc-b24cee1ad23c@oracle.com>
Date:   Thu, 21 Jun 2018 09:43:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180620181601.GA24145@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=592
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for your kindly response.

On 06/21/2018 02:16 AM, Keith Busch wrote:
> On Wed, Jun 20, 2018 at 09:22:39PM +0800, Jianchao Wang wrote:
>> Dear all
>>
>> scsi timeout and error handler are based on an assumption that normal
>> completion mustn't do anything on an timeout request. After 12f5b931
>> (blk-mq: Remove generation seqeunce), we lost this. __blk_mq_complete
>> request could ensure a request won't be completed twice, but it can
>> still complete a timeout request.
>> scsi (even other drivers) have been working on this assumption for many
>> years, it is dangerous to discard it suddenly. This patch set is to regain this.
> 
> I certainly don't want to harm any drivers. Could you possibly explain
> what about removing silent execptions from the completion handler and
> letting drivers control the destiny of requests they own is "dangerous"?

Letting LLDD control the destiny of requests they own is great idea !
But some of the LLDD (such as scsi) depends on an assumption (or setup)
normal completion mustn't do anything on an timeout request and this is provided
by block layer before 12f5b931 (blk-mq: Remove generation seqeunce) for many years.
timer and IO completion will both attempt to 'grab' the request, we have to make
sure that only one of them succeeds.

We could also refer to the following segment of the Documentation/scsi/scsi_eh.txt
" Note that this does not mean lower layers are quiescent.  If a LLDD
completed a scmd with error status, the LLDD and lower layers are
assumed to forget about the scmd at that point.  However, if a scmd
has timed out, unless hostt->eh_timed_out() made lower layers forget
about the scmd, which currently no LLDD does, the command is still
active as long as lower layers are concerned and completion could
occur at any time.  Of course, all such completions are ignored as the
timer has already expired.
"

So we have to preserve the ability of block layer that it could prevent
IO completion path from entering a timeout request.

With scsi-debug module, I tried to simulate a scenario where timeout and IO
completion path could occur concurrently, the system ran into crash easily.

> 
> A initial look at your proposal looks pretty harmful to me. A driver may
> return BLK_EH_RESET_TIMER, then call blk_mq_complete_req from another
> thread, and your patch will simply lose that request and escalate error
> recovery. That seems exactly what you shouldn't want to happen.
> 
Yes, this is indeed a hole.
The escalated error recovery should could handle this.
And it will be a better scenario than the one caused by trace between io completion
and timeout path.

Thanks
Jianchao

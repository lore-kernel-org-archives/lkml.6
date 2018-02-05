Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeBESdw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:33:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35908 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753748AbeBESdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:33:38 -0500
Subject: Re: [PATCH] pvcalls-back: do not return error on inet_accept EAGAIN
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: jgross@suse.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.10.1802021728420.10160@sstabellini-ThinkPad-X260>
 <936e4d18-3f0d-3fc5-2272-c1ad9a5c7022@oracle.com>
 <alpine.DEB.2.10.1802050953570.10160@sstabellini-ThinkPad-X260>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <abe7aeba-ad27-467d-3da0-1026f5966a43@oracle.com>
Date: Mon, 5 Feb 2018 13:34:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802050953570.10160@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8796 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802050234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 01:01 PM, Stefano Stabellini wrote:
> On Sun, 4 Feb 2018, Boris Ostrovsky wrote:
>> On 02/02/2018 08:34 PM, Stefano Stabellini wrote:
>>> When the client sends a regular blocking accept request, the backend is
>>> expected to return only when the accept is completed, simulating a
>>> blocking behavior, or return an error.
>>>
>>> Specifically, on EAGAIN from inet_accept, the backend shouldn't return
>>> "EAGAIN" to the client. Instead, it should simply continue the wait.
>>> Otherwise, the client will send another accept request, which will cause
>>> another EAGAIN to be sent back, which is a waste of resources and not
>>> conforming to the expected behavior. Change the behavior by turning the
>>> "goto error" into a return.
>>>
>>> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
>>
>> I am looking at SYSCALL_DEFINE4(accept4) and sock->ops->accept (which *I
>> think* is inet_accept, at least in some cases) passes all errors (including
>> EAGAIN)  back to the caller. Is this a different case?
> Hi Boris,
>
> I didn't explain myself well. You are right that inet_accept passes all
> errors back to the caller, but this is different: not only it would be a
> waste of resources to do so, but the different behavior is specified in
> the PVCalls spec:
>
> "The backend will reply to the request only when a new connection is
> successfully accepted, i.e. the backend does not return EAGAIN or
> EWOULDBLOCK."

Got it, thanks.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


-boris


>
> https://xenbits.xen.org/docs/unstable/misc/pvcalls.html
>
> Look under the "Accept" sub-chapter.
>
> Cheers,
>
> Stefano

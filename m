Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2465C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2E218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d6/LATT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeLRV5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:57:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35374 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLRV5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:57:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBILn03A162207;
        Tue, 18 Dec 2018 21:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=rIZJd2cMLWvsLIk+czPSxnxYLnjyiuI06xKRaKYevwI=;
 b=d6/LATT+0qQoBIQf4ta9dye8cXPDui0qLYeqFFCD7OxVkFGQgczQ8W5OcT0l6h0ACEAO
 /0C4fGDlsddhUNxyrh0znD6EiAIcKUySoJavKmplIFK9uKjtRwyixNmw02YzOjwdcA49
 VQpOF3otv0PRse7YqDuBqNiYnCPwzJ6QIliE9Mt9JfcOnthhEuoiP5SAwwpY05T87LIJ
 s6nGj8UQ5f7VjJ4YxZm/3WYG7t5jNqzgxMKFDKWVJ2njlkqjrQQ9x0Egr4mZQeQd80dd
 UPCcA5wB/uYqZ8GNehqOoB/3Ttb1A7Xjfa4OkcNjE4ebi9JxfJLZVZukrRzG4xpAVri1 8Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pct8qwykd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 21:56:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBILusYS001854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 21:56:54 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBILurmT032189;
        Tue, 18 Dec 2018 21:56:53 GMT
Received: from kadam (/41.202.241.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 13:56:52 -0800
Date:   Wed, 19 Dec 2018 00:56:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH -next] x86/xen: Fix read buffer overflow
Message-ID: <20181218215642.GL19692@kadam>
References: <20181218081910.18080-1-yuehaibing@huawei.com>
 <7825d772-338a-e39e-eaff-73e666ef5c08@suse.com>
 <2fe8f6b7-b791-e7ea-6484-491e089321d5@huawei.com>
 <08a359b7-1746-8997-4c19-b60a30ccdd63@citrix.com>
 <0de982b7-3402-9321-bd6a-f40de653f6e1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0de982b7-3402-9321-bd6a-f40de653f6e1@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:35:34PM -0500, Boris Ostrovsky wrote:
> On 12/18/18 6:28 AM, Andrew Cooper wrote:
> > On 18/12/2018 10:42, YueHaibing wrote:
> >> On 2018/12/18 16:31, Juergen Gross wrote:
> >>> On 18/12/2018 09:19, YueHaibing wrote:
> >>>> Fix smatch warning:
> >>>>
> >>>> arch/x86/xen/enlighten_pv.c:649 get_trap_addr() error:
> >>>>  buffer overflow 'early_idt_handler_array' 32 <= 32
> >>>>
> >>>> Fixes: 42b3a4cb5609 ("x86/xen: Support early interrupts in xen pv guests")
> >>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >>>> ---
> >>>>  arch/x86/xen/enlighten_pv.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> >>>> index 2f6787f..81f200d 100644
> >>>> --- a/arch/x86/xen/enlighten_pv.c
> >>>> +++ b/arch/x86/xen/enlighten_pv.c
> >>>> @@ -646,7 +646,7 @@ static bool __ref get_trap_addr(void **addr, unsigned int ist)
> >>>>  
> >>>>  	if (nr == ARRAY_SIZE(trap_array) &&
> >>>>  	    *addr >= (void *)early_idt_handler_array[0] &&
> >>>> -	    *addr < (void *)early_idt_handler_array[NUM_EXCEPTION_VECTORS]) {
> >>>> +	    *addr < (void *)early_idt_handler_array[NUM_EXCEPTION_VECTORS - 1]) {
> >>>>  		nr = (*addr - (void *)early_idt_handler_array[0]) /
> >>>>  		     EARLY_IDT_HANDLER_SIZE;
> >>>>  		*addr = (void *)xen_early_idt_handler_array[nr];
> >>>>
> >>> No, this patch is wrong.
> >>>
> >>> early_idt_handler_array is a 2-dimensional array:
> >>>
> >>> const char
> >>> early_idt_handler_array[NUM_EXCEPTION_VECTORS][EARLY_IDT_HANDLER_SIZE];
> >>>
> >>> So above code doesn't do an out of bounds array access, but checks for
> >>> *addr being in the array or outside of it (note the "<" used for the
> >>> test).
> >> Thank you for your explanation.
> > This looks like a smatch bug.  I'd feed it back upstream.
> 
> +Dan
> 

Yep.  Thanks for the bug report.  Let me test my fix and push it later
this week.

Btw, it might help readability slightly if we made it more clear we were
doing pointer math:

		*addr >= (void *)&early_idt_handler_array[0] &&
		*addr < (void *)&early_idt_handler_array[NUM_EXCEPTION_VECTORS]) {
			nr = (*addr - (void *)&early_idt_handler_array[0]) /

Regardless, this is definitely a bug in Smatch and I will push a fix.

regards,
dan carpenter


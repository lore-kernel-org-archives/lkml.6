Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeDDTaU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:30:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42072 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbeDDTaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:30:13 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Organization: Oracle
To: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com,
        linux-kernel@vger.kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Pasha Tatashin <pasha.tatashin@oracle.com>
Subject: Control dependency between prior load in while condition and later
 store?
Message-ID: <087a5ca4-e788-60ee-9145-3a078781cf05@oracle.com>
Date: Wed, 4 Apr 2018 15:29:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8853 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=576
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A question for memory-barriers.txt aficionados.

Is there a control dependency between the prior load of 'a' and the 
later store of 'c'?:

   while (READ_ONCE(a));
   WRITE_ONCE(c, 1);

I have my doubts because memory-barriers.txt doesn't talk much about 
loops and because of what that document says here:

   In addition, control dependencies apply only to the then-clause and
   else-clause of the if-statement in question.  In particular, it does
   not necessarily apply to code following the if-statement:

   	q = READ_ONCE(a);
   	if (q) {
   		WRITE_ONCE(b, 1);
   	} else {
   		WRITE_ONCE(b, 2);
   	}
   	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from 'a'. */

It's not obvious to me how the then-clause/else-clause idea maps onto 
loops, but if we think of the example at the top like this...

   while (1) {
       if (!READ_ONCE(a)) {
           WRITE_ONCE(c, 1);
           break;
       }
   }

...then the dependent store is within the then-clause.  Viewed this way, 
it seems there would be a control dependency between a and c.

Is that right?

Thanks,
Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755974AbeDZNkf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:40:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45964 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeDZNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:40:33 -0400
Subject: Re: [PATCH v2 net-next 1/2] tcp: add TCP_ZEROCOPY_RECEIVE support for
 zerocopy receive
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Eric Dumazet <eric.dumazet@gmail.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
References: <20180425214307.159264-1-edumazet@google.com>
 <20180425214307.159264-2-edumazet@google.com>
From: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <d3ad6970-4139-76a9-2417-3df077753aa9@oracle.com>
Date: Thu, 26 Apr 2018 21:40:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425214307.159264-2-edumazet@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 05:43 AM, Eric Dumazet wrote:
> When adding tcp mmap() implementation, I forgot that socket lock
> had to be taken before current->mm->mmap_sem. syzbot eventually caught
> the bug.
> 
> Since we can not lock the socket in tcp mmap() handler we have to
> split the operation in two phases.
> 
> 1) mmap() on a tcp socket simply reserves VMA space, and nothing else.
>    This operation does not involve any TCP locking.
> 
> 2) setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) implements
>   the transfert of pages from skbs to one VMA.
>    This operation only uses down_read(&current->mm->mmap_sem) after
>    holding TCP lock, thus solving the lockdep issue.


A quick question.  Is it a normal practice to return a result
in setsockopt() given that the optval parameter is supposed to
be a const void *?




-- 
K. Poon
ka-cheong.poon@oracle.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeDCVCY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:02:24 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.228]:49204 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752639AbeDCVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:02:23 -0400
Subject: Re: [PATCH] cifs: cifssmb: Fix potential NULL pointer dereference
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
References: <20180403205512.GA28804@embeddedor.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <a0bbcf88-37c9-0a73-02ae-6ec63f94484b@embeddedor.com>
Date: Tue, 3 Apr 2018 16:02:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403205512.GA28804@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f3T4Q-000K2q-FQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:42256
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed the subject was incorrect. Drop this patch, please.

I just sent v2.

Thanks
--
Gustavo

On 04/03/2018 03:55 PM, Gustavo A. R. Silva wrote:
> tcon->ses is being dereferenced before it is null checked, hence
> there is a potential null pointer dereference.
> 
> Fix this by moving the pointer dereference after tcon->ses has
> been properly null checked.
> 
> Addresses-Coverity-ID: 1467426 ("Dereference before null check")
> Fixes: 93012bf98416 ("cifs: add server->vals->header_preamble_size")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>   fs/cifs/smb2pdu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index f7741ce..e5ac474 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -3454,7 +3454,7 @@ static int
>   build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon, int level,
>   		   int outbuf_len, u64 persistent_fid, u64 volatile_fid)
>   {
> -	struct TCP_Server_Info *server = tcon->ses->server;
> +	struct TCP_Server_Info *server;
>   	int rc;
>   	struct smb2_query_info_req *req;
>   	unsigned int total_len;
> @@ -3464,6 +3464,8 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon, int level,
>   	if ((tcon->ses == NULL) || (tcon->ses->server == NULL))
>   		return -EIO;
>   
> +	server = tcon->ses->server;
> +
>   	rc = smb2_plain_req_init(SMB2_QUERY_INFO, tcon, (void **) &req,
>   			     &total_len);
>   	if (rc)
> 

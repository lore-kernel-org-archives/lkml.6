Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeC3WXv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 18:23:51 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42576 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeC3WXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 18:23:50 -0400
X-Google-Smtp-Source: AIpwx4+SixNplZVwtcLnLsDK01HNzW09iAkFwI+fUiEwWSqw3CH0cvpIUYdPjtPI1+5ZapQAPJAizujbNmWnKv1Fq/g=
MIME-Version: 1.0
In-Reply-To: <20180330221636.32512-1-longli@linuxonhyperv.com>
References: <20180330221636.32512-1-longli@linuxonhyperv.com>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Sat, 31 Mar 2018 08:23:48 +1000
Message-ID: <CAN05THTrte19yRdyAOHvcjhxmOW=auh=z5nvVXsqcLxbmYn7Dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cifs: smbd: avoid reconnect lockup
To: Long Li <longli@microsoft.com>
Cc: Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me (both patches)

Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>

On Sat, Mar 31, 2018 at 8:16 AM, Long Li <longli@linuxonhyperv.com> wrote:
> From: Long Li <longli@microsoft.com>
>
> During transport reconnect, other processes may have registered memory
> and blocked on transport. This creates a deadlock situation because the
> transport resources can't be freed, and reconnect is blocked.
>
> Fix this by returning to upper layer on timeout. Before returning,
> transport status is set to reconnecting so other processes will release
> memory registration resources.
>
> Upper layer will retry the reconnect. This is not in fast I/O path so
> setting the timeout to 5 seconds.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  fs/cifs/smbdirect.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index 5aa0b54..3f7883e 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -1498,8 +1498,8 @@ int smbd_reconnect(struct TCP_Server_Info *server)
>         log_rdma_event(INFO, "reconnecting rdma session\n");
>
>         if (!server->smbd_conn) {
> -               log_rdma_event(ERR, "rdma session already destroyed\n");
> -               return -EINVAL;
> +               log_rdma_event(INFO, "rdma session already destroyed\n");
> +               goto create_conn;
>         }
>
>         /*
> @@ -1512,15 +1512,19 @@ int smbd_reconnect(struct TCP_Server_Info *server)
>         }
>
>         /* wait until the transport is destroyed */
> -       wait_event(server->smbd_conn->wait_destroy,
> -               server->smbd_conn->transport_status == SMBD_DESTROYED);
> +       if (!wait_event_timeout(server->smbd_conn->wait_destroy,
> +               server->smbd_conn->transport_status == SMBD_DESTROYED, 5*HZ))
> +               return -EAGAIN;
>
>         destroy_workqueue(server->smbd_conn->workqueue);
>         kfree(server->smbd_conn);
>
> +create_conn:
>         log_rdma_event(INFO, "creating rdma session\n");
>         server->smbd_conn = smbd_get_connection(
>                 server, (struct sockaddr *) &server->dstaddr);
> +       log_rdma_event(INFO, "created rdma session info=%p\n",
> +               server->smbd_conn);
>
>         return server->smbd_conn ? 0 : -ENOENT;
>  }
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeFEQHP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:07:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751745AbeFEQHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:07:13 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/5] afs: Show all of a server's addresses in
 /proc/fs/afs/servers
From: David Howells <dhowells@redhat.com>
To: viro@ZenIV.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Jun 2018 17:07:11 +0100
Message-ID: <152821483155.16494.6322560197888640951.stgit@warthog.procyon.org.uk>
In-Reply-To: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
References: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show all of a server's addresses in /proc/fs/afs/servers, placing the
second plus addresses on padded lines of their own.  The current address is
marked with a star.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 3512b9b66caf..0c3285c8db95 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -326,6 +326,7 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 {
 	struct afs_server *server;
 	struct afs_addr_list *alist;
+	int i;
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(m, "UUID                                 USE ADDR\n");
@@ -334,10 +335,15 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 
 	server = list_entry(v, struct afs_server, proc_link);
 	alist = rcu_dereference(server->addresses);
-	seq_printf(m, "%pU %3d %pISp\n",
+	seq_printf(m, "%pU %3d %pISpc%s\n",
 		   &server->uuid,
 		   atomic_read(&server->usage),
-		   &alist->addrs[alist->index].transport);
+		   &alist->addrs[0].transport,
+		   alist->index == 0 ? "*" : "");
+	for (i = 1; i < alist->nr_addrs; i++)
+		seq_printf(m, "                                         %pISpc%s\n",
+			   &alist->addrs[i].transport,
+			   alist->index == i ? "*" : "");
 	return 0;
 }
 

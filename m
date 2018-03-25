Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeCYKMI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 06:12:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43618 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeCYKMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 06:12:07 -0400
Date: Sun, 25 Mar 2018 12:12:04 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.14.29-rt25
Message-ID: <20180325101204.ibuvdpnusv3vutyc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.14.29-rt25 patch set. 

Changes since v4.14.29-rt24:

  - There are checks for disabled interrupts in the target code which do
    not work on RT. Reported by Arnaldo Carvalho de Melo.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.14.29-rt24 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.29-rt24-rt25.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.29-rt25

The RT patch against v4.14.29 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.29-rt25.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.29-rt25.tar.xz

Sebastian

diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index 9c7bc1ca341a..3d35dad1de2c 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -114,8 +114,6 @@ static bool __target_check_io_state(struct se_cmd *se_cmd,
 {
 	struct se_session *sess = se_cmd->se_sess;
 
-	assert_spin_locked(&sess->sess_cmd_lock);
-	WARN_ON_ONCE(!irqs_disabled());
 	/*
 	 * If command already reached CMD_T_COMPLETE state within
 	 * target_complete_cmd() or CMD_T_FABRIC_STOP due to shutdown,
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index e6d51135d105..b00829995131 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -2966,9 +2966,6 @@ __transport_wait_for_tasks(struct se_cmd *cmd, bool fabric_stop,
 	__acquires(&cmd->t_state_lock)
 {
 
-	assert_spin_locked(&cmd->t_state_lock);
-	WARN_ON_ONCE(!irqs_disabled());
-
 	if (fabric_stop)
 		cmd->transport_state |= CMD_T_FABRIC_STOP;
 
@@ -3238,9 +3235,6 @@ static int __transport_check_aborted_status(struct se_cmd *cmd, int send_status)
 {
 	int ret;
 
-	assert_spin_locked(&cmd->t_state_lock);
-	WARN_ON_ONCE(!irqs_disabled());
-
 	if (!(cmd->transport_state & CMD_T_ABORTED))
 		return 0;
 	/*
diff --git a/localversion-rt b/localversion-rt
index b2111a212663..c5b71f9a229d 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt24
+-rt25

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDOTGf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 15:06:35 -0400
Received: from mout.web.de ([212.227.15.4]:49617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752470AbeDOTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 15:06:34 -0400
Date: Sun, 15 Apr 2018 21:06:31 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Passing luks passphrase from grub to systemd
Message-ID: <20180415190631.5nilksv3fr2clxbj@hjlipp.my-fqdn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
X-Provags-ID: V03:K1:j1y0NI8sTjlh/kX1hOi+Wq7SMxlfxEkinCHGZ8/5KiOKZZGKC/k
 08C6nJkUqtZz9ZtupWcrU9yuUmvRFfaOmADGB0iyxqj28/bW3jBlAYlpit8bGQ9V3T/votb
 SoU5LF/6WmBMJfIYu6buvo1K9WfmxKmZHR4xvhA7F7vd997vTJOCRvNsRHqKs8rkLpxJXqM
 ZEhLVaieAn6I27kUdlOhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7QyE8Wnpus8=:9i/W+po2DlMZDlSXfdcNLD
 BCBBYTo5wR3zFxV/GOKenal4SGa4I2eTcP4vN/fIy6K8NGGr8Gv595Sl9wrAWEsMsD26Qw6LE
 MsKTW2M9A3ONf0AFE1zarabEAtKeFnKFj0Z3/c6kmHy/mSXGmsb2+nTDuA6jRR1ZjeNJWjCT/
 3kos8VhuhB2BSquhW7h8bnDszbUeaPFM0DuVn1hGBwhxg/hexMCiSkpRXJl6XmANh7ViR4BK2
 1NJgrMoNMOGbryZnXp+C2mTLhEAqMUxSHax5rUiCFd6zjnfFn/c2REjE3Dhezqw7SYJSFrsyb
 tgNGqg1VnCjJ/rdLknU11mg/EEs1HmaRQxRjeWgfXM0BeWVWzt1XqGVeuCAf2reOTaQJrN0qh
 vKYTWDSHtfelMeOhyLv00w/W1ErcEa7GBZVuKzCMZdpQ62rqaam7oiLvsKIr7qMzZsST+B6iK
 3LWmJK+p5tTzweDJHU3vJ553mEuLRzez9oXMnef3oWjXoQSJLK3X3jmC1mtoiOrn2Mg6hjtUj
 UN1jQDTEo4eg+kVuy1oJI3Q7p97rIWW5FsKn9XlV/WUDMYpz7Vfo8OJeVPkrXptz2wjtiZjSN
 bpWB1LAerdmROlJ/n/AJokZz5mO/ucHUpR1s+4ev34ffjfxbnFyWf4RBmNmOIif9Q0E+32Z4Y
 ZOk9ujhNe0HyPOExBlndYT6hPhX5lL2voEZ4rA1r9OnW04dPNGOZs8nyMmu7CufWksDDFiWyr
 D7VPJ6CkJGGloEVx71AqbHDH5/NeUCORc5Oz4sg1c+5KP/libsYnRrqatOzonZVzkY8oJ+5/g
 kWVOTmNAwq244tGqT/iA3mVesGLow==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as I'm stuck with a (non-EFI x86_64) system with encrypted root
partition, I have to enter the passphrase twice (grub needs it for
getting the kernel etc., systemd needs it for mounting the root
partition). This can be quite inconvenient, especially if the passphrase
is long and contains special characters, and grub assumes a different
keyboard layout.

I therefore developed a proof of concept code allowing grub to pass the
passphrase to the kernel and systemd to get the passphrase from the
kernel. See the description and patch for the Linux part and the link to
all changes below.

I'm presenting my code here because I'd like to know if something like
this might be useful also for other people (and further development
might be sensible). I'd also be thankful for comments how this might be
implemented in a better way.

As I wanted to avoid introducing a new incompatible interface for
passing data to the Linux kernel (all combinations of grub, Linux,
systemd, with and without these changes should still work), I actually
extended the mechanism which is already in place to pass the regular
kernel command line, allowing to reuse existing code in many places.

The secret data is passed as a "hidden command line" following the NUL
character terminating the regular command line. In order to enable Linux
to detect whether a hidden command line exists, it is prefixed with a
signature (currently "hdn "). The hidden command line contains the usual
"key=value" pairs which might be useful fur other purposes; currently,
grub is passing a string "pwd=PASSPHRASE" for every passphrase the user
enters during the boot process. The full format therefore reads
  $regular_cmdline NUL "hdn " $hidden_cmdline NUL

The kernel actually does not interpret the data but leaves this task to
the init process. It merely copies the data to a new variable
hidden_command_line which is read when root reads from the new proc fs
entry /proc/cmdline_hidden. The code does ensure that the hidden command
line is zeroed out as soon as it has been read by root. It might also be
a good idea to restrict access to this entry to the init process?

The systemd changes are quite small as there is already code in place
that stores passphrases entered by the user for mounting further
encrypted devices. The passphrases read from /proc/cmdline_hidden just
have to be fed into that mechanism.

The patch for the current stable kernel can be found below.  Details and
all code can be found at
  http://www.hlipp.de/linux-passphrase-transfer/

Kind regards,
Hansjoerg


 fs/proc/cmdline.c    |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/init.h |    1 
 init/main.c          |   26 ++++++++++++++++++++--
 3 files changed, 85 insertions(+), 2 deletions(-)

--- linux-orig/include/linux/init.h
+++ linux/include/linux/init.h
@@ -126,6 +126,7 @@
 extern int do_one_initcall(initcall_t fn);
 extern char __initdata boot_command_line[];
 extern char *saved_command_line;
+extern char *hidden_command_line;
 extern unsigned int reset_devices;
 
 /* used by init/main.c */
--- linux-orig/init/main.c
+++ linux/init/main.c
@@ -129,6 +129,8 @@
 char __initdata boot_command_line[COMMAND_LINE_SIZE];
 /* Untouched saved command line (eg. for /proc) */
 char *saved_command_line;
+/* Saved hidden command line (for /proc; can be 0) */
+char *hidden_command_line;
 /* Command line for parameter parsing */
 static char *static_command_line;
 /* Command line for per-initcall parameter parsing */
@@ -369,13 +371,33 @@
  */
 static void __init setup_command_line(char *command_line)
 {
+	size_t len = strlen(boot_command_line);
 	saved_command_line =
-		memblock_virt_alloc(strlen(boot_command_line) + 1, 0);
+		memblock_virt_alloc(len + 1, 0);
 	initcall_command_line =
-		memblock_virt_alloc(strlen(boot_command_line) + 1, 0);
+		memblock_virt_alloc(len + 1, 0);
 	static_command_line = memblock_virt_alloc(strlen(command_line) + 1, 0);
 	strcpy(saved_command_line, boot_command_line);
 	strcpy(static_command_line, command_line);
+
+	/* Detect hidden command line parameters.
+	 * The format is: Regular parameters, 0, "hdn ", hidden parameters, 0
+	 */
+	if (len < COMMAND_LINE_SIZE - 6
+	    && boot_command_line[len + 1] == 'h'
+	    && boot_command_line[len + 2] == 'd'
+	    && boot_command_line[len + 3] == 'n'
+	    && boot_command_line[len + 4] == ' '
+	   ) {
+		size_t len2;
+		boot_command_line[COMMAND_LINE_SIZE - 1] = 0; /* Make sure the string is 0 terminated. */
+		len2 = strlen(boot_command_line + len + 5);
+		hidden_command_line = memblock_virt_alloc(len2 + 1, 0);
+		strcpy(hidden_command_line, boot_command_line + len + 5);
+		memset(boot_command_line + len + 5, 0, len2); /* Zero out hidden parameters. */
+	} else {
+		hidden_command_line = 0;
+	}
 }
 
 /*
--- linux-orig/fs/proc/cmdline.c
+++ linux/fs/proc/cmdline.c
@@ -22,9 +23,69 @@
 	.release	= single_release,
 };
 
+static DEFINE_SPINLOCK(cmdline_lock);
+
+static int cmdline_hidden_proc_show(struct seq_file *m, void *v)
+{
+	char *cmdline = 0;
+	size_t len;
+
+	/* Hidden data can only be read once! */
+	spin_lock(&cmdline_lock);
+	if (hidden_command_line) {
+		cmdline = hidden_command_line;
+		hidden_command_line = 0;
+	}
+	spin_unlock(&cmdline_lock);
+
+	/* No hidden command line found, or already read. */
+	if (!cmdline) {
+		seq_printf(m, "\n");
+		return 0;
+	}
+
+	seq_printf(m, "%s\n", cmdline);
+
+	/* Zero out data. */
+	len = strlen(cmdline);
+	memset(cmdline, 0, len);
+	//memblock_free(__pa(cmdline), len + 1); // Should we somehow make this work or just "leak" this memory?
+	//kmalloc()/kfree() is probably also bad in init/main.c:setup_command_line().
+
+	return 0;
+}
+
+static int cmdline_hidden_proc_open(struct inode *inode, struct file *file)
+{
+	/* Only root may open this. */
+	if (!uid_eq(current_euid(), GLOBAL_ROOT_UID)) {
+	//if (!uid_eq(current_euid(), GLOBAL_ROOT_UID) || current->pid != 1) { /* We could also restrict access to the init process. */
+		return -EACCES;
+	}
+	return single_open(file, cmdline_hidden_proc_show, NULL);
+}
+
+static int cmdline_hidden_proc_release(struct inode *inode, struct file *file)
+{
+	/* Zero out data. */
+	struct seq_file *m = file->private_data;
+	if (m->buf) {
+		memset(m->buf, 0, m->size);
+	}
+	return single_release(inode, file);
+}
+
+static const struct file_operations cmdline_hidden_proc_fops = {
+	.open		= cmdline_hidden_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= cmdline_hidden_proc_release,
+};
+
 static int __init proc_cmdline_init(void)
 {
 	proc_create("cmdline", 0, NULL, &cmdline_proc_fops);
+	proc_create("cmdline_hidden", 0, NULL, &cmdline_hidden_proc_fops);
 	return 0;
 }
 fs_initcall(proc_cmdline_init);
